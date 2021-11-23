class SpotsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @spot = Spot.new
    @note = Note.find(params[:note_id])
    @user = User.find(current_user.id)
    @user_notes = Note.includes(:tags).where(user_id: @user.id).all
  end
  
  def create
    @spot = Spot.new(spot_params)
    @note = Note.find(params[:note_id])
    @spot.note_id = @note.id
    if @spot.save
    else
      @user = User.find(current_user.id)
      redirect_to request.referer
    end
  end
  
  def destroy
    @note = Note.find(params[:note_id])
    Spot.find(params[:id]).destroy
  end
  
  private
  
  def spot_params
    params.require(:spot).permit(:address, :latitude, :longitude, :title, :body)
  end
  
end
