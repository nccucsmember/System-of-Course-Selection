class CourseController < ApplicationController

  def index

    @course = Coursedetail.all
    render :json => @course

  end

  def show

    @course = Coursedetail.find(params[:id])
    render :json => @course

  end

end
