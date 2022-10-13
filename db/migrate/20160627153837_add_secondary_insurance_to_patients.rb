class AddSecondaryInsuranceToPatients < ActiveRecord::Migration
  def change
  	add_column :patients, :sec_ssn, :string
    add_column :patients, :sec_insurance_company, :string
    add_column :patients, :sec_insurance_id, :integer
    add_column :patients, :sec_ign, :string
    add_column :patients, :sec_isn, :string
    add_column :patients, :sec_ins_subscriber_dob, :date
    add_column :patients, :sec_ins_subscriber_ssn, :string
  end
end
