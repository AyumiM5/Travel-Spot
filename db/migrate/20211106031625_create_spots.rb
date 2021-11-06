class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.integer :schedule_id
      t.integer :row_order
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
