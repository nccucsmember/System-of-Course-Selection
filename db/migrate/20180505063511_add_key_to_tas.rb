class AddKeyToTas < ActiveRecord::Migration[5.1]
  def change
	  change_column :ta, :TA_id, :string, :primary_key => true
  end
end
