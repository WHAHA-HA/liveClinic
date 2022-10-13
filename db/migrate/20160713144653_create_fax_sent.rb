class CreateFaxSent < ActiveRecord::Migration
  def change
    create_table :fax_sents do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :to
      t.string :file
      t.string :notes

      t.integer :status

      t.timestamps null: false
    end
  end
end
