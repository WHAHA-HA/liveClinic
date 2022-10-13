class CreateChitChats < ActiveRecord::Migration
  def change
    create_table :chit_chats do |t|
      t.belongs_to :patient, index: true, foreign_key: true
      t.belongs_to :doctor, index: true, foreign_key: true
      t.belongs_to :encounter, index: true, foreign_key: true
      t.string :chit_chat
      t.integer :status
      t.datetime :date

      t.timestamps null: false
    end
  end
end
