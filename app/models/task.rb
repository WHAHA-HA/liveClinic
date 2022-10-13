class Task < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient
  belongs_to :doctor_staff, :foreign_key => 'provider_id'
end
