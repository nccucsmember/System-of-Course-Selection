class AddColumnsToChooses < ActiveRecord::Migration[5.1]
  def change
        add_column :chooses, :course_id, :string, :null => false
		add_column :chooses, :student_id, :string, :null => false

  end
end
