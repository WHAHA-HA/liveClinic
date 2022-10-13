class AddFaxQueueIdToFaxSent < ActiveRecord::Migration
  def change
  	add_column :fax_sents, :queue_id, :string
  	add_column :fax_sents, :message, :string
  end
end
