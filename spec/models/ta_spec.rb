require 'rails_helper'

RSpec.describe Ta do

	context 'when there is a ta record in database' do
		before(:all) do
			@ta = Ta.new(:TA_id => '789',
						 :name => 'test_name',
						 :email => 'test@test.com')
			@course = Course.new(:course_id => 'testid',
									:semester => '1062',
								    :subject_id => 'testid',
								    :TA_id => @ta.TA_id)
		end

		it 'should have a ta id' do
			expect(@ta.TA_id).not_to be_empty
		end

		it 'should have name' do
			expect(@ta.name).not_to be_empty
		end

		it 'should have email' do
			expect(@ta.email).not_to be_empty
		end

		it "has_many courses" do
			#post = Post.create(:title => "title", :content => "content")
			expect(@ta.courses).to include(@course)
		end
	end
end

