class RemoveQFromPatients < ActiveRecord::Migration
  def change
    remove_column :patients, :q
  end
end
