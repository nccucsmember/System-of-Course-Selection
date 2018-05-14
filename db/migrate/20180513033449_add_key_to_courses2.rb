class AddKeyToCourses2 < ActiveRecord::Migration[5.1]
  def change
	  execute "ALTER TABLE `courses` DROP PRIMARY KEY"
	  change_column :courses, :subject_id, :string, :primary_key => true
  end
end
