class ManagecourseController < ApplicationController

  layout "application"

  def index
     render "managecourse/managecourse"
  end

  def show
     render "managecourse/managecourse"
  end

  def update

     @course = Coursedetail.find(params[:id])
     Rails.logger.debug(@course.course_teacher)

  end

end
