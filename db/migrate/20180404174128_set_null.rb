class SetNull < ActiveRecord::Migration[5.1]
  def change
        change_column :users, :schoolid, :string, :null => false
  end
end
