class Diagnostic < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :request
end
