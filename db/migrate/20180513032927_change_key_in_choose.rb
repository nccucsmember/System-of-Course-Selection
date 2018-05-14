class ChangeKeyInChoose < ActiveRecord::Migration[5.1]
  def change
	  change_column :courses, :course_id, :string, :primary_key => false
  end
end
