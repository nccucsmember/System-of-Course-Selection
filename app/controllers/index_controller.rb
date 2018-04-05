class IndexController < ApplicationController


    layout "application"

    def welcome

    end

    def main
      if user_signed_in?
          @info = PersonalInfor.find_by_schoolid(current_user.schoolid)
          respond_to do |format|
            format.json { render json: @info }
            format.html
          end
      else

      end
    end



end
