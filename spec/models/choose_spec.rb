require 'rails_helper'

RSpec.describe Choose do
	
	context 'when there is a chooses record in database' do

		let(:choose) { Choose.create!(:course_id => 'testid',
								  :student_id => '34343434',
								  :cs_id => 'testid34343434',
								  :is_chosen => '0',
								  :chosen_order => 3)}

		it 'should have a course id' do
			expect(choose.course_id).not_to be_empty
		end

		it 'should have student_id' do
			expect(choose.student_id).not_to be_empty
		end

		it 'should have cs_id' do
			expect(choose.cs_id).not_to be_empty
		end

		it 'should have is_chosen' do
			expect(choose.is_chosen).not_to be_empty
		end

		it 'should have chosen_order' do
			expect(choose.chosen_order).to eq(3)
		end
	end
end




