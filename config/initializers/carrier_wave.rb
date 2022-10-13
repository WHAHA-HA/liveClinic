require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|
  config.root = Rails.root
  config.permissions = 0600
  config.directory_permissions = 0700
end