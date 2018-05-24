require "rails_helper"

RSpec.describe ManagecourseController, type: :controller do

  describe "GET a person's tracking list" do

    it "find the tracking list and render json" do

      @user =  User.create!(:email => 'joy1111@gmail.com', :password => 'aaaaaaa', :schoolid => "12121212")
      @course = Course.find_by_sql(["select courses.* from courses,chooses where chooses.course_id=subject_id and student_id=?", @user.schoolid])

      request.headers["Authorization"] = "#{@user.authentication_token}"

      get :index

      @tracking_list = {:course_list => @course, :message => "OK"}.to_json

      expect(response.body).to be_json_eql(@tracking_list)

    end

  end

end
