class Note < ApplicationRecord
  
  belongs_to :user
  has_many :spots, dependent: :destroy
  has_many :note_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :image 
    
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :stay, presence: true
  validates :body, presence: true, length: { maximum: 50 }
  validates :status, presence: true
  
  enum stay: { 'day_trip': 0, '1n_2d': 1, '2n_3d': 2, '3n_4d': 3, '4n_5d': 4 }
  
end
