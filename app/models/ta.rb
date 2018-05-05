class Ta < ApplicationRecord
	self.primary_key = "TA_id"
	has_many :courses
end
