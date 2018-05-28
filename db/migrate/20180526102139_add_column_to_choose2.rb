class AddColumnToChoose2 < ActiveRecord::Migration[5.1]
  def change
	  add_column :chooses, :isChosen, :Boolean
  end
end
