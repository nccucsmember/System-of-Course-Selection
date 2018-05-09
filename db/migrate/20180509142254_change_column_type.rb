class ChangeColumnType < ActiveRecord::Migration[5.1]
  def change
	  change_column :courses, :is_general, :string
	  change_column :courses, :central_general, :string
  end
end
