class CreateShortHands < ActiveRecord::Migration
  def change
    create_table :short_hands do |t|
      t.string :name
      t.integer :status

      t.timestamps null: false
    end
  end
end
