class CreateAllergies < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.belongs_to :patient, index: true, foreign_key: true
      t.string :allergy
      t.string :search
      t.string :severity
      t.string :reaction
      t.string :onset
      t.datetime :date
      t.string :comment
      t.integer :status

      t.timestamps null: false
    end
  end
end
