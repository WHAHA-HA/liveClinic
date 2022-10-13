class CreateSoaps < ActiveRecord::Migration
  def change
    create_table :soaps do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.belongs_to :patient, index: true, foreign_key: true
      t.string :note_subjective
      t.string :note_objective
      t.string :note_assessment
      t.string :note_plan
      t.belongs_to :encounter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
