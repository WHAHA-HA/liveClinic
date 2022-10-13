class CreateDoctorSchedules < ActiveRecord::Migration
  def change
    create_table :doctor_schedules do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.datetime :start_time
      t.datetime :endtime

      t.timestamps null: false
    end
  end
end
