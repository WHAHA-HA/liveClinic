class RemoveFewFromPatients < ActiveRecord::Migration
  def change
    remove_column :patients, :birthdate, :datetime
    remove_column :patients, :pharmacy_phone, :string
    remove_column :patients, :address_line, :string
    remove_column :patients, :card_id, :integer
    remove_column :patients, :dod, :string
    remove_column :patients, :date, :datetime
    remove_column :patients, :security_number, :string
    remove_column :patients, :record_number, :string
  end
end
