class ChooseController < ApplicationController

	def index
		# Return the Chosen Course List

		myhash = {:auth_token => request.headers['HTTP_AUTHORIZATION']}
		@user = User.find_by_authentication_token(myhash[:auth_token])

		if @user
			@user_id = @user.schoolid
			@chosen_courses_with_order = Course.find_by_sql([
				'SELECT courses.* 
			 	 FROM courses, chooses 
				 WHERE is_chosen = 1 and student_id = ? and chooses.course_id = subject_id and chosen_order > 0 ORDER BY chosen_order ASC', @user_id])
			@chosen_courses_no_order = Course.find_by_sql([
				'SELECT courses.* 
			 	 FROM courses, chooses 
				 WHERE is_chosen = 1 and student_id = ? and chooses.course_id = subject_id and chosen_order IS NULL', @user_id])


			if @chosen_courses_with_order.empty? and @chosen_courses_no_order.empty?
				render :json => {:message => "No Courses."}
			else
				render :json => {:chosen_courses_list => @chosen_courses_with_order + @chosen_courses_no_order, :message => 'OK'}
			end
		else
			render :json => {:message => 'Invalid user'}
		end
	end



	def update
		### Set the is_chosen field to opposite value

		myhash = {:id => params['id'], :auth_token => request.headers['HTTP_AUTHORIZATION']}
		@user = User.find_by_authentication_token(myhash[:auth_token])

		if @user
			@user_id = @user.schoolid
			@course_id = myhash[:id]

			choose = Choose.find_by(cs_id: @course_id + @user_id)
			if choose != nil
				if choose.is_chosen == '1'
					# put it back to tracking list
					choose.is_chosen = '0'
					choose.chosen_order = nil
				else
					# put it into selected list
					choose.is_chosen = '1'
					max_chosen_order = Choose.where(:student_id => @user_id, :is_chosen => '1').maximum(:chosen_order)
					choose.chosen_order = max_chosen_order + 1
				end

				choose.save

				@chosen_courses = Course.find_by_sql([
					'SELECT courses.* 
					 FROM courses, chooses 
					 WHERE is_chosen = 1 and student_id = ? and chooses.course_id = subject_id ORDER BY chosen_courses ASC', @user_id])

				render :json => {:chosen_courses_list => @chosen_courses, :message => 'OK'}
			else
				render :json => {:message => 'Invalid course.'}
			end
		else
			render :json => {:message => 'Invalid user.'}
		end
	end



	def setorder

		myhash = {:order_list => params['order_list'], :auth_token => request.headers['HTTP_AUTHORIZATION']}

		@user = User.find_by_authentication_token(myhash[:auth_token])

		if @user
			@user_id = @user.schoolid
			@order_list = myhash[:order_list]
			@selected_courses = Choose.find_by_sql([
				'SELECT * 
				 FROM chooses 
				 WHERE is_chosen = 1 and student_id = ?', @user_id])

			i = 1
			@order_list.each {
				|c|
				match = @selected_courses.find { |t| t.course_id == c }
				match.chosen_order = i
				match.save
				i = i + 1
			}

			render :json =>  {:message => 'order has been set.'}
		else
			render :json => {:message => 'Invalid user.'}
		end

	end
end
