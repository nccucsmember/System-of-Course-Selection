class AddKeyToChooses < ActiveRecord::Migration[5.1]
  def change
    execute "ALTER TABLE `chooses` DROP PRIMARY KEY"
	  change_column :chooses, :cs_id, :string, :primary_key => true
  end
end
