class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.integer :user_id
      #t.references :user, foreign_key:true
      t.string :title, null: false
      t.integer :stay, null: false, default: "0"
      t.text :body, null: false
      t.string :image_id
      t.integer :status, null: false
      t.boolean :posted, null: false, default: "false"

      t.timestamps
    end
  end
end
