class CreateAllergySearches < ActiveRecord::Migration
  def change
    create_table :allergy_searches do |t|
      t.belongs_to :allergy, index: true, foreign_key: true
      t.string :allergy_name
      t.string :allergy_status

      t.timestamps null: false
    end
  end
end
