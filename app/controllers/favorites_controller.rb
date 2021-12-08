class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @note = Note.find(params[:note_id])
    favorite = @note.favorites.new(user_id: current_user.id)
    favorite.save
    @note.create_notification_like(current_user)
  end

  def destroy
    @note = Note.find(params[:note_id])
    favorite = @note.favorites.find_by(user_id: current_user.id)
    favorite.destroy
  end
end
