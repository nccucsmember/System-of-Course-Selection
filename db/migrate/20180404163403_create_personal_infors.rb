class CreatePersonalInfors < ActiveRecord::Migration[5.1]
  def change
    create_table :personal_infors do |t|
      t.string :schoolid
      t.string :name
      t.string :role

      t.timestamps
    end
  end
end
