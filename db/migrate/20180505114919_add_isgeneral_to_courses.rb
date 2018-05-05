class AddIsgeneralToCourses < ActiveRecord::Migration[5.1]
  def change
	  add_column :courses, :is_general, :boolean
  end
end
