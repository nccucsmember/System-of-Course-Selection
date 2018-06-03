class Thumbup < ApplicationRecord
	belongs_to :user, :foreign_key => 'auth_token', optional: true
	belongs_to :comment, :foreign_key => 'comment_id', optional: false
end
