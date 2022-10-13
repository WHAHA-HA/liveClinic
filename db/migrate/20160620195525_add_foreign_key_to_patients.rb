class AddForeignKeyToPatients < ActiveRecord::Migration
  def change
  	change_table :patients do |t|
    	t.belongs_to :doctor, index: true, foreign_key: true
	end
  end
end
