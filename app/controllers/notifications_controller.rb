class NotificationsController < ApplicationController
  def index
    @user_notes = Note.user_notes_tag(current_user)
    @notifications = current_user.passive_notifications.where.not(visitor_id: current_user.id).includes(:note, :visitor).limit(30).order(created_at: :desc).page(params[:page]).per(6)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
