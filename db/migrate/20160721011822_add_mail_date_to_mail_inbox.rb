class AddMailDateToMailInbox < ActiveRecord::Migration
  def change
  	add_column :mail_inboxes, :mail_date_utc, :datetime
  end
end
