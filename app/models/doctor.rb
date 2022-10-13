class Doctor < ActiveRecord::Base
  has_one :user, :as => :owner, :dependent => :destroy
  has_one :practice, :dependent => :destroy
  
  has_many :facilities
  has_many :doctor_staffs
  has_many :tasks
  has_many :patients
end
