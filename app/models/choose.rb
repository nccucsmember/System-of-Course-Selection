class Choose < ApplicationRecord
	belongs_to :course, :foreign_key => "course_id"
	belongs_to :student, :foreign_key => "student_id"
end
