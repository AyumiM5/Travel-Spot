class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  attachment :profile_image
  validates :name, uniqueness: true, presence: true, length: { minimum: 2, maximum: 20 }
  
  has_many :notes, dependent: :destroy
  
end
