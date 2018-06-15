require "rails_helper"

RSpec.describe ManagecourseController, type: :controller do

  describe "all feature of tracking system" do

    let(:user) { User.create!(:email => 'joy1111@gmail.com', :password => 'aaaaaaa', :schoolid => "12121212") }
    let(:course) { Course.create!(:course_id => "testcourseid", :semester => '1062', :subject_id => 'testid', :TA_id => '111') }


    context "GET a person's tracking list" do

      it "find the tracking list" do

        request.headers["Authorization"] = "#{user.authentication_token}"

        course
        track = Choose.create!( :cs_id => 'testid12121212', :course_id => 'testid', :student_id => '12121212', :is_chosen => '0' )

        get :index

        @tracking_list = { :course_list => [course], :message => "OK" }.to_json

        expect(response.body).to be_json_eql(@tracking_list)

      end

    end

    context "PATCH a person's new tracking" do

      it "return success message" do

        request.headers["Authorization"] = "#{user.authentication_token}"

        put :update, params: { id: course.subject_id }

        @success = { :message => "The course #{course.subject_id} is add to #{user.schoolid}'s tracking list." }.to_json

        expect(response.body).to be_json_eql(@success)

      end

    end

    context "DELETE a person's past tracking" do

      it "return success message" do

        request.headers["Authorization"] = "#{user.authentication_token}"

        track = Choose.create!( :cs_id => 'testid12121212', :course_id => 'testid', :student_id => '12121212', :is_chosen => '0' )

        delete :destroy, params: { id: course.subject_id }

        @success = { :message => "The course #{course.subject_id} is remove from #{user.schoolid}'s tracking list." }.to_json

        expect(response.body).to be_json_eql(@success)

      end

    end

  end

end
