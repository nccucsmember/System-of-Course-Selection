class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students, :id => false, :primary_key => :student_id do |t|
		t.string :student_id, :null => false, primary_key: true
		t.string :name, :null => false
		t.string :email, :null => false


      t.timestamps
    end
  end
end
