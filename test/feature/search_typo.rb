require "matrix"

# Name_lst is an input from db ( all courses' names )
## Coursedetail.select(:course_name_ch).distinct
name_lst = ["中文", "資料庫", "資料科學", "經濟學", "銀行貨幣學", "運動代表隊"]

#test query
q = "y資料"

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


#query clean
printf "Original Query: %s\n", q
penal = corpus_penalty(q, character_lst)
tmp_q = ""
q.split("").each {|c| if character_lst.include? c; tmp_q << c; end}
q = tmp_q


v2 = vectorize_tf(q, character_lst, index_mapping)
dt_score = {}
name_lst.each do |word|
	dt_score[word] = sim_cosine(vectorize_tf(word, character_lst, index_mapping), v2) * penal
	#printf "%s: %.6f\n", word, sim_cosine(vectorize_tf(word, character_lst, index_mapping), v2)
end


printf "Cleaned Query: %s\npenalty: %.5f\n\n", q, penal
dt_score.each do |k, val|
	printf "%s:   %.4f\n", k, val
end
