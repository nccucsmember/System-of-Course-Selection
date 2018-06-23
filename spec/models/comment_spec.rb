require 'rails_helper'

RSpec.describe Comment do

	context 'when there is a comment in database' do
		let(:comment) { Comment.create!(:id => 10,
										:content => 'It sucks.',
										:good => 28,
										:score => 10.3,
										:subject_id => 'testid',)}
        let(:thumbup) { Thumbup.create!(:id => 5,
										:comment_id => 10,
										:auth_token => '1233321')}

		it 'should have a id' do
			expect(comment.id).to eq(10)
		end

		it 'should have content' do
			expect(comment.content).not_to be_empty
		end

		it 'should have good' do
			expect(comment.good).to eq(28)
		end

		it 'should have score' do
			expect(comment.score).to eq(10.3)
		end

		it 'should have subject_id' do
			expect(comment.subject_id).not_to be_empty
		end

		it "has_many thumbups" do
			expect(comment.thumbups).to include(thumbup)
		end

	end
end
