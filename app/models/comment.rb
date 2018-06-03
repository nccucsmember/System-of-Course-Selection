class Comment < ApplicationRecord
	belongs_to :course, :foreign_key => 'subject_id', optional: true
end
