class CreateMedicalHistories < ActiveRecord::Migration
  def change
    create_table :medical_histories do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.belongs_to :patient, index: true, foreign_key: true
      t.text :major_history
      t.text :ongoing_history
      t.text :allergy_history
      t.text :family_history
      t.text :preventive_history
      t.text :social_history
      t.text :nutrition_history
      t.text :developmental_history
      t.belongs_to :encounter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
