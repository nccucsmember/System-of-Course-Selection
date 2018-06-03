class CreateThumbups < ActiveRecord::Migration[5.1]
  def change
    create_table :thumbups do |t|
		t.string :auth_token, :null => false
		t.integer :comment_id, :null => false

      t.timestamps
    end
  end
end
