class AddKeyToCourses < ActiveRecord::Migration[5.1]
  def change
	  change_column :courses, :course_id, :string, :primary_key => true
  end
end
