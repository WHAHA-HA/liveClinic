class AddFieldsToDoctor < ActiveRecord::Migration
  def change
    add_column :doctors, :fax, :string
    add_column :doctors, :p_facility, :string
    add_column :doctors, :city, :string
    add_column :doctors, :state, :string
  end
end
