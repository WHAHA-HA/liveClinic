class AddRemoveUserFields < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    remove_column :users, :name
    remove_column :users, :nickname
  end
end
