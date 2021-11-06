class Note < ApplicationRecord
  
  belongs_to :user
  
  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :stays, presence: true
  validates :body, presence: true, length: { maximum: 50 }
  validates :status, presence: true
  
  enum stays_method: { 日帰り: 0, '1泊2日': 1, '2泊3日': 2, '3泊4日': 3, '4泊5日': 5 }
  
end
