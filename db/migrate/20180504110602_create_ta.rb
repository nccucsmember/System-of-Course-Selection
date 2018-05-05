class CreateTa < ActiveRecord::Migration[5.1]
  def change
    create_table :ta, :id => false, :primary_key => :TA_id do |t|
		t.string :TA_id, :null => false
		t.string :name, :null => false
		t.string :email, :null => false

      t.timestamps
    end


  end
end
