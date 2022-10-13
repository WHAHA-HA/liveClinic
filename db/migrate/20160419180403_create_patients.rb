class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.datetime :birthdate
      t.string :pharmacy_phone
      t.string :address_line
      t.integer :card_id
      t.string :q
      t.string :dod
      t.string :mobile_number
      t.string :home_phone
      t.string :work_phone
      t.datetime :date
      t.string :security_number
      t.string :record_number
      t.string :country
      t.string :no_mobile
      t.string :no_email
      t.string :send_mobile_text
      t.string :send_voice
      t.string :send_email
      t.string :work_ext
      t.string :method_of_communication
      t.string :suite
      t.string :status

      t.timestamps null: false
    end
  end
end
