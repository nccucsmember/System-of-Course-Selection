class CommentController < ApplicationController


  def ascent

    if Course.find_by(:subject_id => params[:id])!=nil
      #record course name and teacher
      course_name_ch_now = Course.find_by(:subject_id => params[:id]).course_name_ch
      teacher_now = Course.find_by(:subject_id => params[:id]).teacher

      #find the all comments of courses which have the same name and same teacher, and sorted by good ascent
      @comment = Comment.find_by_sql(["select comments.*,semester,num_semesters from comments,courses where comments.subject_id=courses.subject_id and course_name_ch=? and teacher=? order by good asc",course_name_ch_now,teacher_now])

      if @comment.empty?
        render :json => {:message => "No Comments."}
      else
        render :json => {:course_name_ch => course_name_ch_now ,:teacher => teacher_now ,:comment => @comment}
      end

    else
      render :json => {:message => "Invalid Course"}
    end

  end




  def descent

    if Course.find_by(:subject_id => params[:id])!=nil
      course_name_ch_now = Course.find_by(:subject_id => params[:id]).course_name_ch
      teacher_now = Course.find_by(:subject_id => params[:id]).teacher

      #sorted by good descent
      @comment = Comment.find_by_sql(["select comments.*,semester,num_semesters from comments,courses where comments.subject_id=courses.subject_id and course_name_ch=? and teacher=? order by good desc",course_name_ch_now,teacher_now])

      if @comment.empty?
        render :json => {:message => "No Comments."}
      else
        render :json => {:course_name_ch => course_name_ch_now ,:teacher => teacher_now ,:comment => @comment}
      end

    else
      render :json => {:message => "Invalid Course"}
    end

  end




  def time_ascent

    if Course.find_by(:subject_id => params[:id])!=nil
      course_name_ch_now = Course.find_by(:subject_id => params[:id]).course_name_ch
      teacher_now = Course.find_by(:subject_id => params[:id]).teacher

      #sorted by id(time) ascent
      @comment = Comment.find_by_sql(["select comments.*,semester,num_semesters from comments,courses where comments.subject_id=courses.subject_id and course_name_ch=? and teacher=? order by comments.id asc",course_name_ch_now,teacher_now])

      if @comment.empty?
        render :json => {:message => "No Comments."}
      else
        render :json => {:course_name_ch => course_name_ch_now ,:teacher => teacher_now ,:comment => @comment}
      end

    else
      render :json => {:message => "Invalid Course"}
    end

  end




  def time_descent

    if Course.find_by(:subject_id => params[:id])!=nil
      course_name_ch_now = Course.find_by(:subject_id => params[:id]).course_name_ch
      teacher_now = Course.find_by(:subject_id => params[:id]).teacher

      #sorted by id(time) descent
      @comment = Comment.find_by_sql(["select comments.*,semester,num_semesters from comments,courses where comments.subject_id=courses.subject_id and course_name_ch=? and teacher=? order by comments.id desc",course_name_ch_now,teacher_now])

      if @comment.empty?
        render :json => {:message => "No Comments."}
      else
        render :json => {:course_name_ch => course_name_ch_now ,:teacher => teacher_now ,:comment => @comment}
      end

    else
      render :json => {:message => "Invalid Course"}
    end

  end




  def score

    if Course.find_by(:subject_id => params[:id])!=nil
      course_name_ch_now = Course.find_by(:subject_id => params[:id]).course_name_ch
      teacher_now = Course.find_by(:subject_id => params[:id]).teacher

      #calculate the average value of the comments of the courses which have same name and same teacher
      score = Comment.find_by_sql(["select ROUND(avg(comments.score),1) from comments,courses where comments.subject_id=courses.subject_id and course_name_ch=? and teacher=?",course_name_ch_now,teacher_now])

      if score==0
        render :json => {:message => "There have no Comments"}
      else
        render :json => {:score => score}
      end

    else
      render :json => {:message => "Invalid Course"}
    end

  end


  def check_thumbup

    if Course.find_by(:subject_id => params[:id])!=nil
        course_name_ch_now = Course.find_by(:subject_id => params[:id]).course_name_ch
        teacher_now = Course.find_by(:subject_id => params[:id]).teacher

        myhash = {:auth_token => request.headers["HTTP_AUTHORIZATION"]}
        @user = User.find_by_authentication_token(myhash[:auth_token])
        #@user_id = @user.schoolid

        if @user
            @user_id = @user.schoolid
            @comment = Comment.find_by_sql(["select comments.*,semester,num_semesters from comments,courses where comments.subject_id=courses.subject_id and course_name_ch=? and teacher=? order by comments.id desc",course_name_ch_now,teacher_now])
            comment = @comment.as_json
            comment.each {
              |c|
              if Thumbup.find_by(auth_token:myhash[:auth_token], comment_id:c["id"]) == nil
                c["have_thumbup"] = false
              else
                c["have_thumbup"] = true
              end
            }
            render :json => comment
        else
          render :json => {:message =>"Invalid user!"}
        end
    end
  end

  def click_thumbup
      myhash = {:auth_token => request.headers["HTTP_AUTHORIZATION"]}
      @user = User.find_by_authentication_token(myhash[:auth_token])
      @user_id = @user.schoolid

    if @user
      if Thumbup.find_by(auth_token:myhash[:auth_token],comment_id:params[:comment_id]) == nil
        thumbup = Thumbup.new
        thumbup.auth_token=myhash[:auth_token]
        thumbup.comment_id=params[:comment_id]
        thumbup.save
        comment = Comment.find_by(id:params[:comment_id])
        comment.good = comment.good + 1
        comment.save
        render :json => {:message => "#{@user_id} thumbup on comment #{params[:comment_id ]}" , :comment_status => comment}
      else
          thumbup = Thumbup.find_by(auth_token:myhash[:auth_token],comment_id:params[:comment_id])
          thumbup.destroy
          comment = Comment.find_by(id:params[:comment_id])
          comment.good = comment.good - 1
          comment.save
          render :json => {:message => "remove #{@user_id}'s thumbup on comment #{params[:comment_id]}", :comment_status => comment}
      end
    else
      render :json => {:message =>"Invalid user!"}
    end

  end

end
