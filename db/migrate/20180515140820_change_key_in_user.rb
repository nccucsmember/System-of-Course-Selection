class ChangeKeyInUser < ActiveRecord::Migration[5.1]
  def change
	  remove_column :users, :id
	  change_column :users, :schoolid, :string, :primary_key => true
  end
end
