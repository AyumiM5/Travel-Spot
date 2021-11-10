class SpotsController < ApplicationController
  
  def create
    @spot = Spot.new(spot_params)
    @schedule = Schedule.find(params[:schedule_id])
    @spot.schedule_id = @schedule.id
    if @spot.save!
      redirect_to request.referer
    else
      @user = User.find(current_user.id)
      redirect_to request.referer
    end
  end
  
  def destroy
    spot = Spot.find(params[:id])
    spot.destroy
    redirect_to request.referer
  end
  
  private
  
  def spot_params
    params.require(:spot).permit(:address, :latitude, :longitude, :title, :start_time, :end_time)
  end
  
end
