class CreateUserProfile < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      #t.has_one :user, index: true, foreign_key: true
      t.string :personal_email
      t.string :office_phone
      t.string :fax
      t.string :degree
      t.integer :sex
      t.string :primary_specialty
      t.integer :access_level
      t.belongs_to :facility, index: true, foreign_key: true
      
      t.string :city
      t.string :state
      
      t.string :practice_web_addr
      t.string :biography

      # medical license
      t.string :medical_license
      t.date :expiration
      t.string :state_practiced
      t.string :specialty_on_license
      t.string :dea_number
      t.string :upin
      t.string :ein_tin
      t.string :npi_number
      t.string :nadean_number

      t.timestamps null: false
    end
  end
end
