class ChangeColumnOrder2 < ActiveRecord::Migration[5.1]
  def change
	change_table :chooses do |t|
	  t.change :student_id, :string, after: :course_id
	end
  end
end
