class InfoController < ApplicationController
  layout "application"

  def index
      render "layouts/info"
  end

  def edit

  end

  def show
      @info = PersonalInfor.find_by_schoolid(current_user.schoolid)
      render "layouts/info"
  end

end
