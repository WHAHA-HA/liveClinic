class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.string :name
      t.string :phone
      t.string :fax
      t.string :name
      t.string :address
      t.string :suite
      t.string :zip
      t.string :city
      t.string :country_code
      t.string :country
      t.integer :status
      t.integer :team_id
      t.string :time_zone
      t.string :observer

      t.timestamps null: false
    end
  end
end
