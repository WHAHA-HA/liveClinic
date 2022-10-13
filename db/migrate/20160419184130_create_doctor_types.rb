class CreateDoctorTypes < ActiveRecord::Migration
  def change
    create_table :doctor_types do |t|
      t.integer :code
      t.string :name

      t.timestamps null: false
    end
  end
end
