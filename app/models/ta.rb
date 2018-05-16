class Ta < ApplicationRecord
	self.table_name = "tas"
	self.primary_key = "TA_id"
	has_many :courses
	
	belongs_to :user, :foreign_key => "TA_id"
end
