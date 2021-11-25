module NotificationsHelper
  
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