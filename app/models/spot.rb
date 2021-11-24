class Spot < ApplicationRecord
  
  belongs_to :note
  
  validates :note_id, presence: true
  validates :address, presence: true, length: { minimum: 2, maximum: 20 }
  validates :body, presence: true, length: { minimum: 2, maximum: 100 }

  geocoded_by :address
  before_validation :geocode
  
end
