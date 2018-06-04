class ManagecourseController < ApplicationController

  def index

    # request.headers["HTTP_AUTHORIZATION"] -- get user's auth_token
    # params["id"] -- get course_id
    myhash = {:auth_token => request.headers["HTTP_AUTHORIZATION"]}
    @user = User.find_by_authentication_token(myhash[:auth_token])

    if @user

      @user_id = @user.schoolid
      @course = Course.find_by_sql(["select courses.* from courses,chooses where chooses.course_id=subject_id and student_id=?", @user_id])

      render :json => {:course_list => @course , :message => "OK"}
    else
      render :json => {:message =>"Invalid user"}
    end
  end

  def show

  end

  def update
	### The course deposited into table choose is TRACKED, not CHOSEN YET.

    # request.headers["HTTP_AUTHORIZATION"] -- get user's auth_token
    # params["id"] -- get course_id
    myhash = { :id => params["id"], :auth_token => request.headers["HTTP_AUTHORIZATION"]}
    @user = User.find_by_authentication_token(myhash[:auth_token])

    if @user

      @user_id = @user.schoolid
      @course_id = myhash[:id]

      if Choose.find_by(cs_id:@course_id+@user_id)==nil
        choose = Choose.new
        choose.cs_id = @course_id + @user_id
        choose.course_id = @course_id
        choose.student_id = @user_id
		choose.is_chosen = '0' # False means NOT CHOSEN YET.
        choose.save
        if Course.find_by(subject_id:@course_id)!=nil
          render :json => {:message => "The course #{@course_id} is add to #{@user_id}'s tracking list."}
        else
          render :json => {:message => "Invalid course!"}
        end
      else
        render :json => {:message => "The course has been in the checklist!"}
      end

    else
      render :json => {:message =>"Invalid user!"}
    end

  end

  def destroy

    # request.headers["HTTP_AUTHORIZATION"] -- get user's auth_token
    # params["id"] -- get course_id
    myhash = { :id => params["id"], :auth_token => request.headers["HTTP_AUTHORIZATION"]}
    @user = User.find_by_authentication_token(myhash[:auth_token])

    if @user

      @user_id = @user.schoolid
      @course_id = myhash[:id]

      if Choose.find_by(cs_id:@course_id+@user_id)!=nil
        choose = Choose.find_by(course_id:@course_id,student_id:@user_id)
        choose.destroy
        render :json => {:message => "The course #{@course_id} is remove from #{@user_id}'s tracking list."}
      else
        render :json => {:message => "The course isn't in the checklist!"}
      end
    else
      render :json => {:message =>"Invalid user!"}
    end

  end

end
