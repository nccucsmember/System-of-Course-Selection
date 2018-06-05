class AddColumnToChoose3 < ActiveRecord::Migration[5.1]
  def change
	  add_column :chooses, :chosen_order, :integer
  end
end
