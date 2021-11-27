class Tag < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  has_many :note_tags, dependent: :destroy
  has_many :notes, through: :note_tags
end
