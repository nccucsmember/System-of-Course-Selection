class CourseController < ApplicationController

  def index

    hash = {}

    if params[:zh] != nil
      hash[:course_name_ch] = params[:zh]
    end
    if params[:en] != nil
      hash[:course_name_en] = params[:en]
    end
    if params[:sub] != nil
      hash[:course_subject_id] = params[:sub]
    end

    if params[:type] != nil
      hash[:course_type] = params[:type]
    end
    if params[:dept] != nil
      hash[:course_dept] = params[:dept]
    end
    if params[:semester] != nil
      hash[:course_semester] = params[:semester]
    end
    if params[:weekday] != nil
      hash[:course_weekday] = params[:weekday]
    end

    if params[:limit] != nil
      @course = Coursedetail.where(hash).limit(params[:limit])
    else
      @course = Coursedetail.where(hash)
    end
    render :json => @course

  end

  def show

    @course = Coursedetail.find(params[:id])
    render :json => @course

  end

end
