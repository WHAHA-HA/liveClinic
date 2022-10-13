class CreateSocialAdults < ActiveRecord::Migration
  def change
    create_table :social_adults do |t|
      t.belongs_to :patient, index: true, foreign_key: true
      t.integer :children
      t.integer :tobacco_no
      t.integer :tobacco_daily
      t.integer :tobacco_weekly
      t.integer :tobacco_former
      t.integer :alcohol_no
      t.integer :alcohol_daily
      t.integer :alcohol_weekly
      t.integer :alcohol_less
      t.integer :alcohol_former
      t.integer :ex_mod
      t.integer :ex_vig
      t.integer :sed
      t.integer :caff_no
      t.integer :caff_daily
      t.integer :caff_weekly
      t.integer :caff_less
      t.integer :caff_former
      t.integer :fm_che
      t.integer :fm_pipe
      t.integer :fm_cig
      t.integer :fm_cigarette
      t.integer :fm_beer
      t.integer :fm_liquor
      t.integer :fm_other
      t.integer :changes
      t.integer :chocolate
      t.integer :coffee
      t.integer :soda
      t.integer :tea
      t.integer :tablet
      t.integer :c_other
      t.integer :fm_smokeless
      t.integer :how_many

      t.timestamps null: false
    end
  end
end
