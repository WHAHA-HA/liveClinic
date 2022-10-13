class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :user_id
      t.string :customer
      t.string :card

      t.timestamps null: false
    end
  end
end
