class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      
      t.belongs_to :patient, index: true, foreign_key: true
      t.belongs_to :doctor, index: true, foreign_key: true

      t.datetime :due_date
      t.text :desc
    end
  end
end
