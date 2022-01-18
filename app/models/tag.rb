class Tag < ApplicationRecord
  has_many :note_tags, dependent: :destroy
  has_many :public_notes, ->{ where(posted: true, status: 0)},through: :note_tags, source: :note
  has_many :notes, through: :note_tags
end
