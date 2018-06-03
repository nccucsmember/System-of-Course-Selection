class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
		t.string :content
		t.integer :good
		t.float :score
		t.string :subject_id

      t.timestamps
    end
  end
end
