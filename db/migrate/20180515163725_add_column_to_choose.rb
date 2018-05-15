class AddColumnToChoose < ActiveRecord::Migration[5.1]
  def change
    add_column :chooses, :cs_id, :string
  end
end
