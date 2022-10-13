class CreateDiagnostics < ActiveRecord::Migration
  def change
    create_table :diagnostics do |t|
      t.belongs_to :doctor, index: true, foreign_key: true
      t.string :diagnosis
      t.string :medication
      t.integer :charge
      t.belongs_to :request, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
