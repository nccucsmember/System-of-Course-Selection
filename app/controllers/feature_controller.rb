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


    @name_lst = []
    # params[:query]

    @like_result = Coursedetail.find_by_sql ["select course_name_ch from coursedetails where course_name_ch LIKE ?", "%#{params[:query]}%" ]

    if @like_result == []
      #Rails.logger.debug("1231212121")
      puts "NONONONONO"
    end
    render :json => @like_result
    #@name_hash = Coursedetail.select("course_name_ch").distinct
    #@name_hash.each do |n|
    #  @name_lst.push(n.course_name_ch)
    #end


    #render :json => @name_lst

  end

end
