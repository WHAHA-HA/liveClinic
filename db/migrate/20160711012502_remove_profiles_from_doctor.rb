class RemoveProfilesFromDoctor < ActiveRecord::Migration
  def change
  	remove_column :doctors, :personal_email, :string
  	remove_column :doctors, :sex, :string
  	remove_column :doctors, :degree, :string
  	remove_column :doctors, :state_id, :integer
  	remove_column :doctors, :ver_phone, :string
  	remove_column :doctors, :office_phone, :string
    remove_column :doctors, :p_speciality, :string
    remove_column :doctors, :s_speciality, :string
    remove_column :doctors, :p_faculty, :string
    remove_column :doctors, :web_add, :string
    remove_column :doctors, :biography, :string

    remove_column :doctors, :fax, :string
    remove_column :doctors, :city, :string
    remove_column :doctors, :state, :string

    remove_column :doctors, :medical_license, :string
    remove_column :doctors, :expiration, :string
    remove_column :doctors, :state_practice_medicine, :string
    remove_column :doctors, :degree_listed, :string
    remove_column :doctors, :npi_number, :string
    remove_column :doctors, :dea_number, :string
    remove_column :doctors, :upin, :string
    remove_column :doctors, :ein_tin, :string
    remove_column :doctors, :nadean_number, :string

  end
end
