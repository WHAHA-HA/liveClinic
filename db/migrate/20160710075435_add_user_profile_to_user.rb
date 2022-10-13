class AddUserProfileToUser < ActiveRecord::Migration
  def change
  	change_table :users do |t|
    	t.belongs_to :user_profile, index: true, foreign_key: true
	end
  end
end
