class Tag < ApplicationRecord
  
  has_many :note_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :notes, through: :note_tags
  
end
