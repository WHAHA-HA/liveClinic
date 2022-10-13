class CreateVitals < ActiveRecord::Migration
  def change
    create_table :vitals do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.belongs_to :patient, index: true, foreign_key: true
      t.float :height
      t.float :weight
      t.float :bmi
      t.float :bp
      t.float :temp
      t.string :route
      t.float :pulse
      t.float :rr
      t.integer :sat
      t.string :ra
      t.string :pain
      t.datetime :date
      t.belongs_to :encounter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
