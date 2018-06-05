class ChooseController < ApplicationController

	def index
		# Return the Chosen Course List

		myhash = {:auth_token => request.headers['HTTP_AUTHORIZATION']}
		@user = User.find_by_authentication_token(myhash[:auth_token])

		if @user
			@user_id = @user.schoolid
			@chosen_courses = Course.find_by_sql(['SELECT courses.* FROM courses, chooses WHERE is_chosen = 1 and student_id = ? and chooses.course_id = subject_id', @user_id])
			if @chosen_courses.empty?
				render :json => {:message => "No Courses."}
			else
				render :json => {:chosen_courses_list => @chosen_courses, :message => 'OK'}
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
					choose.is_chosen = '0'
				else
					choose.is_chosen = '1'
				end

				choose.save

				@chosen_courses = Course.find_by_sql(['SELECT courses.* FROM courses, chooses WHERE is_chosen = 1 and student_id = ? and chooses.course_id = subject_id', @user_id])

				render :json => {:chosen_courses_list => @chosen_courses, :message => 'OK'}
			else
				render :json => {:message => 'Invalid course.'}
			end
		else
			render :json => {:message => 'Invalid user.'}
		end
	end



	def setorder
		myhash = {:id => params['id'], :order => params['order'], :auth_token => request.headers['HTTP_AUTHORIZATION']}
		
		@user = User.find_by_authentication_token(myhash[:auth_token])
		
		if @user
			@user_id = @user.schoolid
			@course_id = myhash[:id]
			@order = myhash[:order]

			choose = Choose.find_by(cs_id: @course_id + @user_id)
			if choose != nil and choose.is_chosen == '1'
				choose.chosen_order = @order
				choose.save
				
				render :json => {:message => 'Order has been set.'}

			else
				render :json => {:message => 'The course is not in selected list.'}
			end
		else
			render :json => {:message => 'Invalid user.'}
		end
	end
end
