class CourseController < ApplicationController

  def index

    hash = {}
    @course = Coursedetail.all

    if params[:zh] != nil
      @course = @course.where("course_name_ch LIKE ?", "%#{params[:zh]}%")
    end

    if params[:en] != nil
      @course = @course.where("course_name_en LIKE ?", "%#{params[:en]}%")
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


    if params[:limit] != nil and params[:offset] != nil
      @course = @course.where(hash).limit(params[:limit]).offset(params[:limit])
    elsif params[:limit] != nil
      @course = @course.where(hash).limit(params[:limit])
    elsif params[:offset] != nil
      @course = @course.where(hash).offset(params[:limit])
    else
      @course = @course.where(hash)
    end

    render :json => @course

  end

  def show

    @course = Coursedetail.find(params[:id])
    render :json => @course

  end

end
