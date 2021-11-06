class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.integer :user_id
      t.integer :photo_id
      t.integer :schedule_id
      t.string :title, null: false, default: ""
      t.string :stays, null: false, default: ""
      t.text :body, null: false, default: ""
      t.integer :status, null: false, default: "1"

      t.timestamps
    end
  end
end
