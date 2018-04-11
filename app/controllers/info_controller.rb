class InfoController < ApplicationController
  layout "application"

  def index

  end

  def edit

  end

  def show

    if user_signed_in? and current_user.schoolid == params[:id]

      @info = PersonalInfor.find_by_schoolid(params[:id])
      if @info != nil
          render "info"
      else
          render "info_create"
      end

    else
      redirect_to root_path
    end

  end

end
