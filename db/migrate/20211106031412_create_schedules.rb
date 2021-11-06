class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.integer :note_id
      t.integer :day, null: false, default: "0"

      t.timestamps
    end
  end
end
