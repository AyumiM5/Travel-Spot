class SpotsController < ApplicationController
  before_action :authenticate_user!

  def new
    @spot = Spot.new
    @note = Note.find(params[:note_id])
  end

  def create
    @spot = Spot.new(spot_params)
    @note = Note.find(params[:note_id])
    @spot.note_id = @note.id
    render 'error' unless @spot.save
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
