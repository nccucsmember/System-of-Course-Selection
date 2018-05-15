class AddKeyToChooses < ActiveRecord::Migration[5.1]
  def change
	  change_column :chooses, :cs_id, :string, :primary_key => true
  end
end
