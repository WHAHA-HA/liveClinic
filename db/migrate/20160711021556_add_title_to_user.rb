class AddTitleToUser < ActiveRecord::Migration
  def change
  	add_column :users, :title, :string
    remove_column :doctors, :title, :string
  end
end
