class CreateMailInbox < ActiveRecord::Migration
  def change
    create_table :mail_inboxes do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :from
      t.string :title
      t.string :content
      t.string :file

      t.boolean :is_read
      t.integer :mail_type

      t.timestamps null: false
    end
  end
end
