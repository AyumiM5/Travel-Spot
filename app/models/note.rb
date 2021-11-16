class Note < ApplicationRecord
  
  belongs_to :user
  has_many :spots, dependent: :destroy
  has_many :note_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :note_tags, dependent: :destroy
  has_many :tags, through: :note_tags
  attachment :image 
    
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :stay, presence: true
  validates :body, presence: true, length: { maximum: 50 }
  validates :status, presence: true
  
  enum stay: { 'day_trip': 0, '1n_2d': 1, '2n_3d': 2, '3n_4d': 3, '4n_5d': 4 }
  
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end
    
    new_tags.each do |new|
      new_note_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_note_tag
    end
  end
  
end
