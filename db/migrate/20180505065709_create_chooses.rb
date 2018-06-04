class CreateChooses < ActiveRecord::Migration[5.1]
  def change
    create_table :chooses, :id => false do |t|
		  t.string :course_id, :null => false
		  t.string :student_id, :null => false
      t.timestamps
    end
    execute "ALTER TABLE chooses ADD PRIMARY KEY (course_id, student_id);"
  end
end
