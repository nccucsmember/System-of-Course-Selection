class ChangeColumnOrder < ActiveRecord::Migration[5.1]
  def change
  	change_table :courses do |t|
  	  t.change :is_general, :boolean, after: :course_type
  	end
  end
end
