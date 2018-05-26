class ChooseController < ApplicationController
	layout 'application'

	
	def index
		# Return the Chosen Course List

		myhash = {:auth_token => request.headers['HTTP_AUTHORIZATION']}
		@user = User.find_by_authentication_token(myhash[:auth_token])

		if @user
			@user_id = @user.schoolid
			@chosen_courses = Course.find_by_sql(['SELECT courses.* FROM courses, chooses WHERE isChosen = true and student_id = ? and chooses.course_id = subject_id', @user_id])
			render :json => {:chosen_courses_list => @chosen_courses, :message => 'OK'}
		else
			render :json => {:message => 'Invalid user'}
		end
	end

	def update
		### Set the isChosen field 


end
