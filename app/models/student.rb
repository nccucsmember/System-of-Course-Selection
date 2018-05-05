class Student < ApplicationRecord
	self.primary_key = "student_id"

	has_many :chooses
	has_many :courses, :through => :chooses
end
