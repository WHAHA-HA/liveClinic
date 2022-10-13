class CreateAppointmentTypes < ActiveRecord::Migration
  def change
    create_table :appointment_types do |t|
      t.string :type
      t.integer :status

      t.timestamps null: false
    end
  end
end
