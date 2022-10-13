class DoctorStaff < ActiveRecord::Base
  has_one :user, :as => :owner, :dependent => :destroy
  belongs_to :access_level
  belongs_to :doctor

  accepts_nested_attributes_for :user
end
