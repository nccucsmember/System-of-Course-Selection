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
    db_courses = Course.all
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
      'course_id'       => '1351',
      'semester'        => '1062',
      'subject_id'      => '258733002',
      'num_semesters'   => '2',
      'course_name_ch'  => '賽局3',
      'course_name_en'  => 'An Introduction to Game Theory',
      'teacher'         => '何靜嫺',
      'credits'         => '3',
      'begin_time'      => '00:00:00',
      'end_time'        => '00:00:00',
      'weekday'         => '',
      'location'        => '綜合270404',
      'department'      => '經濟碩一經濟碩二',
      'course_type'     => '選',
      'is_general'      => 'False',
      'general_type'    => '',
      'central_general' => 'False',
      'course_maxnum'   => '0',
      'TA_id'           => '',
      'created_at'      => '0000-00-00 00:00:00',
      'updated_at'      => '0000-00-00 00:00:00'
    }


    name_lst = []
    # params[:query]

    @like_result = Course.find_by_sql ["select * from courses where course_name_ch LIKE ?", "%#{query_params['course_name_ch']}%" ]

    re_lst = []

    if @like_result == []
      re_lst = course_name_fuzzysearch(query_params['course_name_ch'])
    else
      @like_result.each do |dic|
        re_lst.push( dic )
      end
    end

    render :json => re_lst

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
