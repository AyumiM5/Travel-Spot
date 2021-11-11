class Note < ApplicationRecord
  
  belongs_to :user
  has_many :schedules, dependent: :destroy
  attachment :image 
  
  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :stays, presence: true
  validates :body, presence: true, length: { maximum: 50 }
  validates :status, presence: true
  
  enum stays_method: { 'day_trip': 0, '1n_2d': 1, '2n_3d': 2, '3n_4d': 3, '4n_5d': 4 }
  
end
