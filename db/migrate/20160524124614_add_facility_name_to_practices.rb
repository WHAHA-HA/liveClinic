class AddFacilityNameToPractices < ActiveRecord::Migration
  def change
    add_column :practices, :facility_name, :string
    add_column :practices, :state, :string
    remove_column :practices, :team_id
    remove_column :practices, :observer
    remove_column :practices, :country_code

  end
end
