class Schedule < ApplicationRecord

  belongs_to :note
  validates :day, presence: true

  has_many :spots, dependent: :destroy
  
 enum day_method: { '1day': 0, '2day': 1, '3day': 2, '4day': 3, '5day': 4 }

end
