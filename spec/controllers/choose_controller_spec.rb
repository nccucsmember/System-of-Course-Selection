require 'rails_helper'
require 'spec_helper'

RSpec.describe ChooseController, type: :controller do

	describe "all features in ChooseController" do

		let(:user) { User.create!(:email => 'joy2222@gmail.com',
								  :password => 'aaaaaaa',
								  :schoolid => "34343434") }
		let(:course) { Course.create!(:course_id => "testcourseid",
									  :semester => '1062',
									  :subject_id => 'testid',
									  :TA_id => '111') }
		#let(:track) { Choose.create!( :cs_id => 'testid34343434',
		#							 :course_id => 'testid',
		#							 :student_id => '34343434',
		#							 :is_chosen => '1',
		#							 :chosen_order => 1)}


		context "#index" do
			it "find the tracking list" do
				request.headers["Authorization"] = "#{user.authentication_token}"

				course
				track = Choose.create!( :cs_id => 'testid34343434',
									    :course_id => 'testid',
										:student_id => '34343434',
										:is_chosen => '1' )

				get :index
				@tracking_list = { :chosen_courses_list => [course], :message => "OK" }.to_json
				expect(response.body).to be_json_eql(@tracking_list)
			end
		end


		context "#update" do

			it "return success message" do

				request.headers["Authorization"] = "#{user.authentication_token}"
				track = Choose.create!( :cs_id => 'testid34343434',
									    :course_id => 'testid',
										:student_id => '34343434',
										:is_chosen => '0' )

				put :update, params: { id: course.subject_id }

				@success = { :chosen_courses_list => [course], :message => 'OK'}.to_json

				expect(response.body).to be_json_eql(@success)

			end

		end


		context "#setorder" do

			it "return success message" do

				request.headers["Authorization"] = "#{user.authentication_token}"
				track = Choose.create!(:cs_id => 'testid34343434',
									   :course_id => 'testid',
									   :student_id => '34343434',
									   :is_chosen => '1',
									   :chosen_order => 2)

				#post :setorder, body: { order_list: ['testid34343434'] }.to_json, format: :json
				post :setorder, params: { order_list: ['testid'] }


				@success = {:message => 'order has been set.'}.to_json

				expect(response.body).to be_json_eql(@success)

			end

		end
	end
end
