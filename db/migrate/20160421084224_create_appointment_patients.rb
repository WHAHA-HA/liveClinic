class CreateAppointmentPatients < ActiveRecord::Migration
  def change
    create_table :appointment_patients do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.belongs_to :patient, index: true, foreign_key: true
      t.string :patient_name
      t.string :provider
      t.string :facility
      t.text :chief_complaint
      t.belongs_to :appointment_type, index: true, foreign_key: true
      t.integer :duration
      t.string :duration_select
      t.datetime :when_time
      t.datetime :end_time
      t.string :repeat_val
      t.string :repeats
      t.string :occurs_on
      t.string :every_day
      t.string :ends_on
      t.string :string
      t.integer :after
      t.string :daily
      t.string :every_week

      t.timestamps null: false
    end
  end
end
