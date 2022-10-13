class AddFacilityAndPatientToDoctorSchedules < ActiveRecord::Migration
  def change
  	change_table :doctor_schedules do |t|
    	t.belongs_to :patient, index: true, foreign_key: true
    	t.belongs_to :facility, index: true, foreign_key: true
	end
  end
end
