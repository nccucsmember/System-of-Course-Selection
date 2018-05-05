class RenameTaToTas < ActiveRecord::Migration[5.1]
  def change
	  rename_table :ta, :tas
  end
end
