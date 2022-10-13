class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.belongs_to :patient, index: true, foreign_key: true
      t.belongs_to :doctor, index: true, foreign_key: true
      t.datetime :creation_time
      t.string :symptoms
      t.string :allergy
      t.integer :complicated
      t.string :pharmacy_phone
      t.boolean :is_video
      t.string :charge_id
      t.integer :rating

      t.timestamps null: false
    end
  end
end
