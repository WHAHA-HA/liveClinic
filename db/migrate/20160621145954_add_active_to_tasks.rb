class AddActiveToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :active, :boolean, :default => false

    change_table :tasks do |t|
    	t.timestamps null: false
    end
  end
end
