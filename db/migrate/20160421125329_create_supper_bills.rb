class CreateSupperBills < ActiveRecord::Migration
  def change
    create_table :supper_bills do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.belongs_to :patient, index: true, foreign_key: true
      t.belongs_to :encounter, index: true, foreign_key: true
      t.string :name
      t.datetime :date

      t.timestamps null: false
    end
  end
end
