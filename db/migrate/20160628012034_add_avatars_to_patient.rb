class AddAvatarsToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :avatar, :string
  end
end
