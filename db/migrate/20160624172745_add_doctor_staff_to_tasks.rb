class AddDoctorStaffToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :provider_id, :integer
  	add_foreign_key :tasks, :doctor_staffs, column: "provider_id"
  end
end
