class ChooseController < ApplicationController

	def index
		# Return the Chosen Course List

		myhash = {:auth_token => request.headers['HTTP_AUTHORIZATION']}
		@user = User.find_by_authentication_token(myhash[:auth_token])

		if @user
			@user_id = @user.schoolid
			@chosen_courses = Course.find_by_sql(['SELECT courses.* FROM courses, chooses WHERE is_chosen = true and student_id = ? and chooses.course_id = subject_id', @user_id])
			render :json => {:chosen_courses_list => @chosen_courses, :message => 'OK'}
		else
			render :json => {:message => 'Invalid user'}
		end
	end

	def update
		### Set the isChosen field to opposite value

		myhash = {:id => params['id'], :auth_token => request.headers['HTTP_AUTHORIZATION']}
		@user = User.find_by_authentication_token(myhash[:auth_token])

		if @user
			@user_id = @user.schoolid
			@course_id = myhash[:id]

			choose = Choose.find_by(cs_id: @course_id + @user_id)
			if choose != nil
				choose.is_chosen = !choose.is_chosen
				choose.save

				@chosen_courses = Course.find_by_sql(['SELECT courses.* FROM courses, chooses WHERE is_chosen = true and student_id = ? and chooses.course_id = subject_id', @user_id])

				render :json => {:chosen_courses_list => @chosen_courses, :message => 'OK'}
			else
				render :json => {:message => 'Invalid course.'}
			end
		else
			render :json => {:message => 'Invalid user.'}
		end
	end
end
