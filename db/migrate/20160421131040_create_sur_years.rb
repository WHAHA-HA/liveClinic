class CreateSurYears < ActiveRecord::Migration
  def change
    create_table :sur_years do |t|
      t.belongs_to :patient, index: true, foreign_key: true
      t.string :name1
      t.string :name2
      t.string :name3
      t.string :name4
      t.string :name5
      t.string :name6
      t.string :name7
      t.string :name8
      t.string :name9
      t.string :name10
      t.string :name11
      t.string :name12
      t.string :name13
      t.string :name14
      t.string :name15
      t.string :name16
      t.string :name17
      t.string :name18
      t.string :name19
      t.string :name20
      t.string :name21
      t.string :name22
      t.string :name23
      t.string :name24
      t.string :name25
      t.string :name26
      t.string :name27
      t.string :name28
      t.string :name29
      t.string :name30
      t.string :name31
      t.string :name32
      t.string :name33
      t.string :name34
      t.string :name35
      t.string :name36
      t.string :name37
      t.string :name38
      t.string :name39
      t.string :name40

      t.timestamps null: false
    end
  end
end
