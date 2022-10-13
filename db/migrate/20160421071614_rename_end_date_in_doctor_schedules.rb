class RenameEndDateInDoctorSchedules < ActiveRecord::Migration
  def change
    rename_column :doctor_schedules, :endtime, :end_time
  end
end
