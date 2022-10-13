class AddStateToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :state, :string
    remove_column :facilities, :suite
    remove_column :facilities, :date
    rename_column :facilities, :country_code, :country
  end
end
