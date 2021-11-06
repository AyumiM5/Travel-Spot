class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.integer :note_id
      t.string :notes_image_id

      t.timestamps
    end
  end
end
