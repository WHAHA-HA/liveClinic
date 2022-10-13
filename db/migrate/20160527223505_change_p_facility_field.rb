class ChangePFacilityField < ActiveRecord::Migration
  def change
    remove_column :doctors, :p_facility
    add_column :doctors, :p_facility, :integer
  end
end
