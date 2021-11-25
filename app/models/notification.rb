class Notification < ApplicationRecord
  
  default_scope -> { order(created_at: :desc) }
  belongs_to :note, optional: true
  belongs_to :note_comment, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_item = link_to 'あなたの投稿', users_item_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.comment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href:users_user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.name, href:users_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_item_path(notification.item_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
          @comment = Comment.find_by(id: @visiter_comment)&.content
          tag.a(@visiter.name, href:users_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_item_path(notification.item_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end
  
end
