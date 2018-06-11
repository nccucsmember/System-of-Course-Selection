require "matrix"

class CourseController < ApplicationController

  def sim_cosine(v1, v2)
  	v1 = v1.normalize
  	v2 = v2.normalize
  	l1 = v1.norm
  	l2 = v2.norm
  	if l1 == 0 or l2 == 0
  		return 0
  	end

  	return v1.dot(v2)
  end

  def corpus_penalty(q, character_lst)
  	original_len = q.size
  	valid_len = 0
  	q.split("").each{ |c| if character_lst.include? c; valid_len += 1; end}
  	#printf "valid_len: %d", valid_len
  	smoothing = 5
  	valid_len += smoothing
  	original_len += smoothing
  	return (valid_len.to_f / original_len.to_f)
  end

  def vectorize_tf(string, character_lst, index_mapping)
  	tmp_vec_lst = Array.new( character_lst.size, 0 )
  	string.split("").each { |c| tmp_vec_lst[index_mapping[c]] += 1 }
  	return Vector.elements(tmp_vec_lst)
  end

  def course_name_fuzzysearch(query)
    name_lst = []
    db_courses = Course.all.as_json
    courses = []
    db_courses.each do |tuple|
      courses << tuple
    end
    @name_hash = Course.select("course_name_ch").distinct
    @name_hash.each do |n|
      name_lst.push(n.course_name_ch)
    end

    # Build unique character lst
    character_lst = []
    name_lst.each { |word| word.split("").each { |c| character_lst << c  } }
    character_lst = character_lst.uniq
    counter = 0

    # Build index mapping for vsm
    index_mapping = {}
    character_lst.each do |c|
      index_mapping[c] = counter
      counter += 1
    end

    #query clean
    q = query
    printf "Original Query: %s\n", q
    penal = corpus_penalty(q, character_lst)
    tmp_q = ""
    q.split("").each {|c| if character_lst.include? c; tmp_q << c; end}
    q = tmp_q
    if tmp_q == ""
      return courses
    end

    v2 = vectorize_tf(q, character_lst, index_mapping)
    dt_score = {}
    name_lst.each do |word|
      dt_score[word] = sim_cosine(vectorize_tf(word, character_lst, index_mapping), v2) * penal
      #printf "%s: %.6f\n", word, sim_cosine(vectorize_tf(word, character_lst, index_mapping), v2)
    end

    printf "Cleaned Query: %s\npenalty: %.5f\n\n", q, penal
    lst_name_score = []
    dt_score.each do |k, val|
      tmp = [k, val]
      lst_name_score.push( tmp )
    end
    re_lst = []
    sorted_lst_name_score = lst_name_score.sort_by { |tuple| tuple[1] }.reverse
    sorted_lst_name_score.each do |t|
      if t[1] > 0.45
        re_lst.push( t[0] )
        printf "%s:   %.4f\n", t[0], t[1]
      else
        break
      end
    end

    return_lst = []
    courses.each do |tuple|
      if re_lst.include?( tuple['course_name_ch'] )
        #printf "%s not in tuple", tuple['course_name_ch']
        return_lst << tuple
      end
    end

    return return_lst
    #return courses

  end

  def search


    query_params = {
      #'course_id'       => '1351',
      #'semester'        => '1062',
      'subject_id'      => params["subject_id"],#'258733002',
      'num_semesters'   => params["num_semesters"],
      'course_name_ch'  => params["course_name_ch"],#'賽局3',
      'teacher'         => params["teacher"],#'何靜嫺',
      'credits'         => params["credits"],
      'weekday'         => [],
      #'begin_time'      => '00:00:00', #TimeWithZone
      #'end_time'        => '00:00:00',
      #'location'        => '綜合270404',
      #'department'      => '經濟碩一經濟碩二',
      'course_type'     => params["course_type"],
      'is_general'      => params["is_general"],
      'general_type'    => params["general_type"],
      'central_general' => params["central_general"]
    }

    # if specified subject_id
    if query_params['subject_id'] != nil and query_params['subject_id'] != ""
      re_lst = Course.where( :subject_id => query_params['subject_id'] )
      render :json => re_lst
      return
    end

    #filter with course name
    re_lst = []
    @like_result = Course.find_by_sql ["select * from courses where course_name_ch LIKE ?", "%#{query_params['course_name_ch']}%" ]
    if @like_result == []
      re_lst = course_name_fuzzysearch(query_params['course_name_ch'])
    else
      @like_result = @like_result.as_json
      @like_result.each do |dic|
        re_lst.push( dic )
      end
    end

    #filter with other params
    return_lst = []
    re_lst.each do |t|
      flag = true
      if t['num_semesters'] != query_params['num_semesters']
        #puts "num_semesters not match"
        #re_lst.delete(t)
        flag = false

      elsif not t['teacher'].include? query_params['teacher']
        #puts "teacher not match"
        flag = false
        #re_lst.delete(t)

      elsif t['credits'] != query_params['credits']
        #puts "credits not match"
        flag = false
        #re_lst.delete(t)

      elsif (query_params['weekday'] != [] and t['weekday'] != [] and (not query_params['weekday'].include? t['weekday']))
        puts "weekday not match"
        flag = false
        #re_lst.delete(t)

      elsif t['course_type'] != query_params['course_type']
        #puts "course_type not match"
        flag = false
        #re_lst.delete(t)

      elsif t['is_general'] != query_params['is_general']
        #puts "is_general not match"
        flag = false
        #re_lst.delete(t)

      elsif t['general_type'] != query_params['general_type']
        #puts "general_type not match"
        flag = false
        #re_lst.delete(t)

      elsif t['central_general'] != query_params['central_general']
        #puts "central_general not match"
        flag = false
        #re_lst.delete(t)
      end

      if flag
        return_lst << t
      end

    end

    return_dt = {
      "count": return_lst.length,
      "course_list": return_lst
    }

    render :json => return_dt

  end

  def index

    hash = {}
    @course = Course.all

    if params[:zh] != nil
      @course = @course.where("course_name_ch LIKE ?", "%#{params[:zh]}%")
    end

    if params[:en] != nil
      @course = @course.where("course_name_en LIKE ?", "%#{params[:en]}%")
    end
    if params[:sub] != nil
      hash[:course_subject_id] = params[:sub]
    end

    if params[:type] != nil
      hash[:course_type] = params[:type]
    end
    if params[:dept] != nil
      hash[:course_dept] = params[:dept]
    end
    if params[:semester] != nil
      hash[:course_semester] = params[:semester]
    end
    if params[:weekday] != nil
      hash[:course_weekday] = params[:weekday]
    end


    if params[:limit] != nil and params[:offset] != nil
      @course = @course.where(hash).limit(params[:limit]).offset(params[:offset])
    elsif params[:limit] != nil
      @course = @course.where(hash).limit(params[:limit])
    elsif params[:offset] != nil
      @course = @course.where(hash).offset(params[:offset])
    else
      @course = @course.where(hash)
    end

    render :json => @course

  end

  def show

    @course = Course.find(params[:id])
    render :json => @course

  end

end
