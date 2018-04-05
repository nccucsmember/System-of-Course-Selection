class InfoController < ApplicationController
  layout "application"

  def index

  end

  def edit

  end

  def show
      @info = PersonalInfor.find_by_schoolid(current_user.schoolid)
      if @info != nil
          render "info"
      else
          render "info_create"
      end
  end

end
