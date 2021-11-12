class CreateNoteComments < ActiveRecord::Migration[5.2]
  def change
    create_table :note_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :note_id

      t.timestamps
    end
  end
end
