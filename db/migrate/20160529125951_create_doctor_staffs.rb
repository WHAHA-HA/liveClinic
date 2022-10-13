class CreateDoctorStaffs < ActiveRecord::Migration
  def change
    create_table :doctor_staffs do |t|
      t.belongs_to :access_level, index: true, foreign_key: true
      t.boolean :is_admin

      t.timestamps null: false
    end
  end
end
