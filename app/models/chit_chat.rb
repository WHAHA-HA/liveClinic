class ChitChat < ActiveRecord::Base
  belongs_to :patient
  belongs_to :doctor
  belongs_to :encounter
end
