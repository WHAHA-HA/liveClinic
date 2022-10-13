class CreateFaxInbox < ActiveRecord::Migration
  def change
    create_table :fax_inboxes do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :from
      t.string :file
      t.boolean :is_read

      t.timestamps null: false
    end
  end
end
