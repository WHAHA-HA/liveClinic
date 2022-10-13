class AddIsAdminToDoctor < ActiveRecord::Migration
  def change
    remove_column :doctors, :access_level
    add_reference :doctors, :access_level, index: true
    add_column :doctors, :is_admin, :boolean
  end
end
