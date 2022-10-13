class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.integer :call_time
      t.integer :calls_col
      t.integer :request_id

      t.timestamps null: false
    end
  end
end
