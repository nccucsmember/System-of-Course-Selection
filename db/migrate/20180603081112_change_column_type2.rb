class ChangeColumnType2 < ActiveRecord::Migration[5.1]
  def change
	  change_column :chooses, :isChosen, :string
	  rename_column :chooses, :isChosen, :is_chosen
  end
end
