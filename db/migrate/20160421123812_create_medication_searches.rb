class CreateMedicationSearches < ActiveRecord::Migration
  def change
    create_table :medication_searches do |t|
      t.string :appl_no
      t.string :product_no
      t.string :form
      t.string :dosage
      t.string :product_mkt_status
      t.string :te_code
      t.string :reference_drug
      t.string :m_name
      t.string :active_ingred

      t.timestamps null: false
    end
  end
end
