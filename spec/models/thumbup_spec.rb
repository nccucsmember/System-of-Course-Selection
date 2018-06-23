require 'rails_helper'

RSpec.describe Thumbup do

	context 'when there is a thumbup record in database' do
		let(:comment) { Comment.create!(:id => 10,
										:content => 'It sucks.',
										:good => 28,
										:score => 10.3,
										:subject_id => 'testid',)}
        let(:thumbup) { Thumbup.create!(:id => 5,
										:comment_id => comment.id,
										:auth_token => '1233321')}

		it 'should have a id' do
			expect(thumbup.id).to eq(5)
		end

		it 'should have comment_id' do
			expect(thumbup.comment_id).to eq(10)
		end

		it 'should have auth_token' do
			expect(thumbup.auth_token).not_to be_empty
		end
	end
end
