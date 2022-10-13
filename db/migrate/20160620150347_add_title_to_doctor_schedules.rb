class AddTitleToDoctorSchedules < ActiveRecord::Migration
  def change
    add_column :doctor_schedules, :title, :string
  end
end
