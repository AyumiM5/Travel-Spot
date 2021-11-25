class NoteComment < ApplicationRecord
  belongs_to :note
  belongs_to :user
  has_many :notifications, dependent: :destroy

  validates :comment, presence: true, length: { minimum: 2, maximum: 50 }
end
