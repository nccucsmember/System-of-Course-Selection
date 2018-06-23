require 'rails_helper'

RSpec.describe CommentController, type: :controller do

	describe "all features in ChooseController" do

		let(:user) { User.create!(:email => 'joy2222@gmail.com',
								  :password => 'aaaaaaa',
								  :schoolid => "34343434",
	   							  :authentication_token => '123321')}
		let(:course) { Course.create!(:course_id => "testcourseid",
									  :semester => '1062',
									  :subject_id => 'testid',
									  :course_name_ch => '測試',
									  :teacher => '測試先生',
									  :TA_id => '111') }
		let(:comment_1) { Comment.create!(:id => 10,
										  :content => 'It sucks.',
										  :good => 28,
										  :score => 10.3,
										  :subject_id => 'testid',)}
		let(:comment_2) { Comment.create!(:id => 11,
										  :content => 'WTF',
										  :good => 34,
										  :score => 7.3,
										  :subject_id => 'testid')}
		let(:comment_3) { Comment.create!(:id => 12,
										  :content => 'nice.',
										  :good => 3,
										  :score => 79.3,
										  :subject_id => 'testid')}
		#let(:track) { Choose.create!( :cs_id => 'testid34343434',
		#							 :course_id => 'testid',
		#							 :student_id => '34343434',
		#							 :is_chosen => '1',
		#							 :chosen_order => 1)}

        let(:thumbup) { Thumbup.create!(:id => 5,
										:comment_id => 10,
										:auth_token => user.authentication_token)}

		context "#ascent" do
			it "find all comments of a given coure" do

				course
				comment_1
				comment_2
				comment_3

				com_1 = {:id => 10,
						 :content => 'It sucks.',
						 :good => 28,
						 :score => 10.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_2 = {:id => 11,
						 :content => 'WTF',
						 :good => 34,
						 :score => 7.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_3 = {:id => 12,
						 :content => 'nice.',
						 :good => 3,
						 :score => 79.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}

				get :ascent, params: {id: 'testid'}
				@comments_list = {:course_name_ch => course.course_name_ch, :teacher => course.teacher, :comment => [com_3, com_1, com_2]}.to_json
				expect(response.body).to be_json_eql(@comments_list)
			end
		end


		context "#descent" do
			it "find all comments of a given coure" do

				course
				comment_1
				comment_2
				comment_3

				com_1 = {:id => 10,
						 :content => 'It sucks.',
						 :good => 28,
						 :score => 10.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_2 = {:id => 11,
						 :content => 'WTF',
						 :good => 34,
						 :score => 7.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_3 = {:id => 12,
						 :content => 'nice.',
						 :good => 3,
						 :score => 79.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}

				get :descent, params: {id: 'testid'}
				@comments_list = {:course_name_ch => course.course_name_ch, :teacher => course.teacher, :comment => [com_2, com_1, com_3]}.to_json
				expect(response.body).to be_json_eql(@comments_list)
			end
		end


		context "#time_ascent" do
			it "find all comments of a given coure" do

				course
				comment_1
				comment_2
				comment_3

				com_1 = {:id => 10,
						 :content => 'It sucks.',
						 :good => 28,
						 :score => 10.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_2 = {:id => 11,
						 :content => 'WTF',
						 :good => 34,
						 :score => 7.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_3 = {:id => 12,
						 :content => 'nice.',
						 :good => 3,
						 :score => 79.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}

				get :time_ascent, params: {id: 'testid'}
				@comments_list = {:course_name_ch => course.course_name_ch, :teacher => course.teacher, :comment => [com_1, com_2, com_3]}.to_json
				expect(response.body).to be_json_eql(@comments_list)
			end
		end


		context "#time_descent" do
			it "find all comments of a given coure" do

				course
				comment_1
				comment_2
				comment_3

				com_1 = {:id => 10,
						 :content => 'It sucks.',
						 :good => 28,
						 :score => 10.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_2 = {:id => 11,
						 :content => 'WTF',
						 :good => 34,
						 :score => 7.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_3 = {:id => 12,
						 :content => 'nice.',
						 :good => 3,
						 :score => 79.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}

				get :time_descent, params: {id: 'testid'}
				@comments_list = {:course_name_ch => course.course_name_ch, :teacher => course.teacher, :comment => [com_3, com_2, com_1]}.to_json
				expect(response.body).to be_json_eql(@comments_list)
			end
		end


		context "#score" do
			it "find all comments of a given coure" do

				course
				comment_1
				comment_2
				comment_3

				com_1 = {:id => 10,
						 :content => 'It sucks.',
						 :good => 28,
						 :score => 10.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_2 = {:id => 11,
						 :content => 'WTF',
						 :good => 34,
						 :score => 7.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_3 = {:id => 12,
						 :content => 'nice.',
						 :good => 3,
						 :score => 79.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}

				get :score, params: {id: 'testid'}
				@ave_score = {:score => [{'avg(comments.score)': 32.3}]}.to_json
				expect(response.body).to be_json_eql(@ave_score)
			end
		end


		context "#give_thumbup" do
			it "give thumbup to a comment" do

				course
				comment_1
				comment_2
				comment_3

				com_1 = {:id => 10,
						 :content => 'It sucks.',
						 :good => 28,
						 :score => 10.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_2 = {:id => 11,
						 :content => 'WTF',
						 :good => 34,
						 :score => 7.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_3 = {:id => 12,
						 :content => 'nice.',
						 :good => 3,
						 :score => 79.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}

        		request.headers["Authorization"] = "#{user.authentication_token}"
				put :give_thumbup, params: {id: 'testid', comment_id: 10}
				comment_1.good += 1
				@msg = {:message => "#{user.schoolid} thumbup on comment 10", :updated_comment => comment_1}.to_json
				expect(response.body).to be_json_eql(@msg)
			end
		end


		context "#remove_thumbup" do
			it "remove a thumbup of a comment" do

				course
				comment_1
				comment_2
				comment_3
				thumbup

				com_1 = {:id => 10,
						 :content => 'It sucks.',
						 :good => 28,
						 :score => 10.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_2 = {:id => 11,
						 :content => 'WTF',
						 :good => 34,
						 :score => 7.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}
				com_3 = {:id => 12,
						 :content => 'nice.',
						 :good => 3,
						 :score => 79.3,
						 :subject_id => 'testid',
						 :semester => '1062',
						 :num_semesters => nil}

        		request.headers["Authorization"] = "#{user.authentication_token}"
				put :remove_thumbup, params: {id: 'testid', comment_id: 10}


				comment_1.good -= 1
				@msg = {:message => "remove #{user.schoolid}'s thumbup on comment 10", :updated_comment => comment_1}.to_json
				expect(response.body).to be_json_eql(@msg)
			end
		end
	end
end

