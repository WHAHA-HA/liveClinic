class CreateHealthExamDates < ActiveRecord::Migration
  def change
    create_table :health_exam_dates do |t|
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

      t.timestamps null: false
    end
  end
end
