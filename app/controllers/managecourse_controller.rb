class ManagecourseController < ApplicationController

  layout "application"

  def index
     render "managecourse/managecourse"
  end

  def show
     render "managecourse/managecourse"
  end

  def update

    # request.headers["HTTP_AUTHORIZATION"] -- get user's auth_token
    # params["id"] -- get course_id
    myhash = { :id => params["id"], :auth_token => request.headers["HTTP_AUTHORIZATION"]}
    @user = User.find_by_authentication_token(request.headers["HTTP_AUTHORIZATION"])

    
    render :json => {:schoolid => @user.schoolid}

  end

end
