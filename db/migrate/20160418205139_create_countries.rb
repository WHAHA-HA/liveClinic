class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :ios
      t.string :name
      t.string :nicename
      t.string :ios3
      t.integer :numcode
      t.integer :phonecode

      t.timestamps null: false
    end
  end
end
