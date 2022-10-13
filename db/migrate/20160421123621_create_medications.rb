class CreateMedications < ActiveRecord::Migration
  def change
    create_table :medications do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.belongs_to :patient, index: true, foreign_key: true
      t.string :search
      t.string :shorthand
      t.string :sig
      t.string :diagnosis
      t.datetime :start_date
      t.datetime :end_date
      t.string :dis_reason
      t.string :comment
      t.integer :status
      t.string :form
      t.string :dosage
      t.string :product_no
      t.string :fev

      t.timestamps null: false
    end
  end
end
