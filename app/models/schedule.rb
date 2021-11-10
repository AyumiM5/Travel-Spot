class Schedule < ApplicationRecord
  
  belongs_to :note
  validates :day, presence: true
  
  has_many :spots, dependent: :destroy
  
  enum day_method: { '1日目': 0, '2日目': 1, '3日目': 2, '4日目': 3, '5日目': 5 }
  
end
