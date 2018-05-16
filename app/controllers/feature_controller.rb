require "matrix"

class FeatureController < ApplicationController

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


  def search


    name_lst = []
    # params[:query]

    @like_result = Course.find_by_sql ["select course_name_ch from coursedetails where course_name_ch LIKE ?", "%#{params[:query]}%" ]

    re_lst = []

    if @like_result == []

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
      q = params[:query]
      printf "Original Query: %s\n", q
      penal = corpus_penalty(q, character_lst)
      tmp_q = ""
      q.split("").each {|c| if character_lst.include? c; tmp_q << c; end}
      q = tmp_q
      if tmp_q == ""
        render :json => []
        return
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
      sorted_lst_name_score = lst_name_score.sort_by { |tuple| tuple[1] }.reverse

      sorted_lst_name_score.each do |t|
        if t[1] > 0.45
          re_lst.push( t[0] )
          printf "%s:   %.4f\n", t[0], t[1]
        else
          break
        end
      end
    else
      @like_result.each do |dic|
        re_lst.push(dic['course_name_ch'])
      end

    end


    render :json => re_lst



    #render :json => @name_lst

  end

end
