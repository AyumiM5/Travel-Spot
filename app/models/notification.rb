class Notification < ApplicationRecord

  default_scope -> { order(created_at: :desc) }
  belongs_to :note, optional: true
  belongs_to :note_comment, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
  
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    @visiter_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentか
    case notification.action
    when "follow" then
      tag.a(notification.visiter.name, href:users_user_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
    when "like" then
      tag.a(notification.visiter.name, href:users_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:users_item_path(notification.item_id), style:"font-weight: bold;")+"にいいねしました"
    when "comment" then
        @comment = Comment.find_by(id: @visiter_comment)&.content
        tag.a(@visiter.name, href:users_user_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿' , href:users_item_path(notification.item_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end
  
  def notification_form(notification)
    @visitor = notification.visitor
    @note_comment = nil
    @visitor_comment = notification.comment_id
    case notification.action
    when 'follow'
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'があなたをフォローしました'
    when 'like'
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: note_path(notification.note_id)) + 'にいいねしました'
    when 'comment' then
      @note_comment = NoteComment.find_by(id: @visitor_comment)
      @note_comment_content =@note_comment.comment
      @note_title =@note_comment.note.title
      tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@note_title}", href: micropost_path(notification.micropost_id)) + 'にコメントしました'
    end
  end
  
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
  
end
