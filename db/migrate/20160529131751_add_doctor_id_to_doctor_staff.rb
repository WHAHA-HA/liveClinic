class AddDoctorIdToDoctorStaff < ActiveRecord::Migration
  def change
    add_reference :doctor_staffs, :doctor, index: true
  end
end
