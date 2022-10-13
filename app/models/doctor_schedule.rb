class DoctorSchedule < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient
  belongs_to :facility
end
