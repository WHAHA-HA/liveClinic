class CreateMailSent < ActiveRecord::Migration
  def change
    create_table :mail_sents do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :to
      t.string :title
      t.string :content
      t.string :file
      
      t.integer :status
      t.integer :mail_type

      t.timestamps null: false
    end
  end
end
