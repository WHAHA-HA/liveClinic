class AddSfaxInfosToUserProfile < ActiveRecord::Migration
  def change
  	add_column :user_profiles, :sfax_apikey, :string
  	add_column :user_profiles, :sfax_username, :string
  	add_column :user_profiles, :sfax_encryptionkey, :string
  end
end
