class AddKey < ActiveRecord::Migration[5.1]
  def change
        change_column :personal_infors, :schoolid, :string, :null => false
  end

end
