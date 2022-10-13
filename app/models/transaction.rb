class Transaction < ActiveRecord::Base
  belongs_to :request
end
