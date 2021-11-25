class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  validates :name, uniqueness: true, presence: true, length: { minimum: 2, maximum: 10 },
                   format: { with: /\A[a-zA-Z0-9]+\z/ }
  validates :email, uniqueness: true

  has_many :notes, dependent: :destroy
  has_many :note_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :active_relationships,  class_name:  'Relationship', foreign_key: 'follower_id', dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship', foreign_key: 'followed_id', dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  def unfollow(user_name)
    user = User.find_by(name: user_name)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def to_param
    name
  end

  def self.search_for(word)
    User.where('name like?', "%#{word}%")
  end

  def self.guest
    find_or_create_by(name: 'Guest') do |user|
      user.email    = SecureRandom.alphanumeric(15) + '@email.com'
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now
    end
  end

  def active_for_authentication?
    super && (users_status == false)
  end
  
  def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      if notification.valid?
        notification.save 
      end
    end
  end
  
end