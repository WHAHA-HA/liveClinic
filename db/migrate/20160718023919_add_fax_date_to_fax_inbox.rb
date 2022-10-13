class AddFaxDateToFaxInbox < ActiveRecord::Migration
  def change
  	add_column :fax_inboxes, :fax_date_utc, :datetime
  	add_column :fax_inboxes, :json, :string
  end
end
