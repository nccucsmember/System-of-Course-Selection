class AddIndex < ActiveRecord::Migration[5.1]
  def change
        add_index :personal_infors, :schoolid
  end
end
