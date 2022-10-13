class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :request, index: true, foreign_key: true
      t.float :price
      t.datetime :date

      t.timestamps null: false
    end
  end
end
