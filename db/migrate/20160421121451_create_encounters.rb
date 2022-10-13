class CreateEncounters < ActiveRecord::Migration
  def change
    create_table :encounters do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.belongs_to :patient, index: true, foreign_key: true
      t.string :encounter_type
      t.string :note_type
      t.datetime :date
      t.string :seen_by
      t.string :facility
      t.integer :status
      t.text :chief

      t.timestamps null: false
    end
  end
end
