class Note < ApplicationRecord
  belongs_to :user
  has_many :spots, dependent: :destroy
  has_many :note_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :note_tags, dependent: :destroy
  has_many :tags, through: :note_tags
  has_many :notifications, dependent: :destroy
  attachment :image

  validates :title, presence: true, length: { minimum: 2, maximum: 20 }
  validates :stay, presence: true
  validates :body, presence: true, length: { minimum: 2, maximum: 50 }
  validates :status, presence: true

  enum stay: { 'day_trip': 0, '1n_2d': 1, '2n_3d': 2, '3n_4d': 3, '4n_5d': 4 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # タグの作成と編集
  def save_tag(sent_tags)
    current_tags = tags.pluck(:tag_name) unless tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      tags.delete Tag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_note_tag = Tag.find_or_create_by(tag_name: new)
      tags << new_note_tag
    end
  end

  # 検索欄
  def self.search_for(word)
    Note.where('title like? OR body like?', "%#{word}%", "%#{word}")
  end

  # Topページのいいねの多い投稿を表示
  def self.best_note
    find(Favorite.group(:note_id).order(Arel.sql('count(note_id) desc')).limit(3).pluck(:note_id))
  end

  # ユーザーの全投稿とタグの取り出し
  def self.user_notes_tag(user)
    includes(:tags).where(user_id: user.id)
  end
  
  # 公開投稿を選び、最新順に並び替える(index)
  def self.public_note_index
    Note.includes(:user, :spots, :tags).where(posted: true, status: 0).order(created_at: :desc)
  end

  # 公開投稿を選び、最新順に並び替える(show)
  def self.public_note
    Note.includes(:spots, :tags).where(posted: true, status: 0).order(created_at: :desc)
  end

  # 非公開、公開投稿を選び、最新順に並び替える(mypage)
  def self.private_public_note
    Note.includes(:spots, :tags).where(posted: true).order(created_at: :desc)
  end

  # いいね通知作成
  def create_notification_like(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and note_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        note_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      if notification.valid?
        notification.save
      end
    end
  end

  def save_notification_comment(current_user, note_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      note_id: id,
      note_comment_id: note_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    if notification.valid?
      notification.save
    end
  end
end
