class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.float :price
      t.integer :state_id
      t.string :title
      t.string :degree
      t.string :sex
      t.string :p_speciality
      t.string :access_level
      t.string :s_speciality
      t.string :p_faculty
      t.string :web_add
      t.string :biography
      t.string :medical_license
      t.string :medical_license
      t.datetime :expiration
      t.string :state_practice_medicine
      t.string :degree_listed
      t.string :npi_number
      t.string :dea_number
      t.string :upin
      t.string :ein_tin
      t.string :nadean_number
      t.string :personal_email
      t.string :ver_phone
      t.string :office_phone
      t.string :extension

      t.timestamps null: false
    end
  end
end
