require 'rails_helper'

RSpec.describe Course do

	context 'when there is a course record in database' do

		let(:course) { Course.create!(:course_id => 'testid',
									  :semester => '1062',
									  :subject_id => 'testid',
									  :TA_id => '789')}
		let(:choose) { Choose.create!(:course_id => 'testid',
								  :student_id => '34343434',
								  :cs_id => 'testid34343434',
								  :is_chosen => '0',
								  :chosen_order => 3)}

		it 'should have a course id' do
			expect(course.course_id).not_to be_empty
		end

		it 'should have semester' do
			expect(course.semester).not_to be_empty
		end

		it 'should have subject_id' do
			expect(course.subject_id).not_to be_empty
		end

		it 'should have TA_id' do
			expect(course.TA_id).not_to be_empty
		end

		it "has_many chooses" do
			#post = Post.create(:title => "title", :content => "content")
			expect(course.chooses).to include(choose)
		end
	end
end
