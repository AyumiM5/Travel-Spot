class Spot < ApplicationRecord
  
  belongs_to :note
  
  # 存在性のバリデーション
  validates :note_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true

  # バリデーションの前に送信されたaddressの値によってジオコーディング(緯度経度の算出)を行う
  geocoded_by :address
  before_validation :geocode
  
end
