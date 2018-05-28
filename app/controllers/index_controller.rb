class IndexController < ApplicationController

    def main

      @courses = Coursedetail.all

      respond_to do |format|
            format.json { render :json => {:courses => @courses }}
            format.html
      end
    end

end
