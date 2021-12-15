class Notification < ApplicationRecord
  belongs_to :note, optional: true
  belongs_to :note_comment, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id'

  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    @visiter_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentか
  end
end
