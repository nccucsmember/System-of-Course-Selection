class Comment < ApplicationRecord
	belongs_to :course, :foreign_key => 'subject_id', optional: true

	has_many :thumbups
	has_many :users, :through => :thumbups
	
end
