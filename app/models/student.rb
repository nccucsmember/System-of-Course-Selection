class Student < ApplicationRecord
	self.primary_key = "student_id"

	has_many :chooses
	has_many :courses, :through => :chooses

	belongs_to :user, :foreign_key => "student_id"
end
