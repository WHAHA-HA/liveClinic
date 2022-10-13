class CreateCtpCodes < ActiveRecord::Migration
  def change
    create_table :ctp_codes do |t|
      t.integer :concept_id
      t.integer :code
      t.string :descriptor_id
      t.string :descriptor

      t.timestamps null: false
    end
  end
end
