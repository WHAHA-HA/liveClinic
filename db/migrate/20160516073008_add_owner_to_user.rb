class AddOwnerToUser < ActiveRecord::Migration
  def change
    add_column :users, :owner_id, :integer
    add_column :users, :owner_type, :string
    add_index :users, [:owner_id, :owner_type]
  end
end
