class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.string :name
      t.string :phone
      t.string :fax
      t.string :address
      t.string :suite
      t.string :zip
      t.string :city
      t.string :country_code
      t.datetime :date
      t.integer :status

      t.timestamps null: false
    end
  end
end
