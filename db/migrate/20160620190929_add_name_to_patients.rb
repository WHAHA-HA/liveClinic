class AddNameToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :f_name, :string
    add_column :patients, :m_name, :string
    add_column :patients, :l_name, :string
    add_column :patients, :n_name, :string
    add_column :patients, :email, :string
    add_column :patients, :state, :string
    add_column :patients, :city, :string
    add_column :patients, :address, :string
    add_column :patients, :zip, :string
    add_column :patients, :dob, :date
    add_column :patients, :gender, :string
    add_column :patients, :ssn, :string
    add_column :patients, :insurance_company, :string
    add_column :patients, :insurance_id, :integer
    add_column :patients, :ign, :string
    add_column :patients, :isn, :string
    add_column :patients, :ins_subscriber_dob, :date
    add_column :patients, :ins_subscriber_ssn, :string
  end
end
