class Course < ApplicationRecord
	self.primary_key = "subject_id"

	belongs_to :ta, :foreign_key => "TA_id", optional: true

	has_many :chooses
	has_many :students, :through => :chooses
end
