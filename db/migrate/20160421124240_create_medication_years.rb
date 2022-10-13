class CreateMedicationYears < ActiveRecord::Migration
  def change
    create_table :medication_years do |t|
      t.belongs_to :patient, index: true, foreign_key: true
      t.datetime :date1
      t.datetime :date2
      t.datetime :date3
      t.datetime :date4
      t.datetime :date5
      t.datetime :date6
      t.datetime :date7
      t.datetime :date8
      t.datetime :date9
      t.datetime :date10
      t.datetime :date11
      t.datetime :date12
      t.datetime :date13
      t.datetime :date14
      t.datetime :date15
      t.datetime :date16
      t.datetime :date17
      t.datetime :date18
      t.datetime :date19
      t.datetime :date20
      t.datetime :date21
      t.datetime :date22
      t.datetime :date23
      t.datetime :date24
      t.datetime :date25
      t.datetime :date26
      t.datetime :date27
      t.datetime :date28
      t.datetime :date29
      t.datetime :date30
      t.datetime :date31
      t.datetime :date32
      t.datetime :date33
      t.datetime :date34

      t.timestamps null: false
    end
  end
end
