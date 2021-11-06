class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :title, null: false
      t.integer :stays, null: false, default: "0"
      t.text :body, null: false
      t.integer :status, null: false, default: "1"

      t.timestamps
    end
  end
end
