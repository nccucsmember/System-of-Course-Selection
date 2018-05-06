class FeatureController < ApplicationController

  def search

    @name_lst = []
    # params[:query]

    @name_hash = Coursedetail.select("course_name_ch").distinct
    @name_hash.each do |n|
      @name_lst.push(n.course_name_ch)
    end

    render :json => @name_lst

  end

end
