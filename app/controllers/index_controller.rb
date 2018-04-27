class IndexController < ApplicationController


    layout "application"

    def main

      @courses = Coursedetail.all

      if user_signed_in?
          @info = PersonalInfor.find_by_schoolid(current_user.schoolid)
          respond_to do |format|
            format.json { render :json => {:user => @info, :courses => @courses }}
            format.html
          end
      else

      end


    end



end
