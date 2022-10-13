class CreatePediatricForms < ActiveRecord::Migration
  def change
    create_table :pediatric_forms do |t|
      t.belongs_to :patient, index: true, foreign_key: true
      t.string :pri_m
      t.string :pri_f
      t.string :pri_b
      t.string :pri_s
      t.string :pri_both
      t.string :pri_other
      t.string :sec_m
      t.string :sec_f
      t.string :sec_other
      t.string :rel
      t.string :ch_m
      t.string :ch_f
      t.string :ch_sibling
      t.string :ch_gra
      t.string :ch_nanny
      t.string :ch_day_care
      t.string :tobacco
      t.string :smokers
      t.string :cur_smokers

      t.timestamps null: false
    end
  end
end
