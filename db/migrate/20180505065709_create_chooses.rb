class CreateChooses < ActiveRecord::Migration[5.1]
  def change
    create_table :chooses, :id => false do |t|
		  t.string :course_id, :null => false, primary_key: true
		  t.string :student_id, :null => false, primary_key: true
      t.timestamps
    end
  end
end
