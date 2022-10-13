class AddPhimailInfosToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :phimail_email, :string
    add_column :user_profiles, :phimail_password, :string
  end
end
