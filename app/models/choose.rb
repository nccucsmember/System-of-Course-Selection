class Choose < ApplicationRecord
	self.primary_key = "cs_id"
	belongs_to :course, :foreign_key => "course_id", optional: true
	belongs_to :student, :foreign_key => "student_id", optional: true
end
