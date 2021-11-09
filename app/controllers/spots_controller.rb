class SpotsController < ApplicationController
  
  def new
    @user = User.find(current_user.id)
    @spot = Spot.new
    @schedule = Schedule.find_by(id: params[:schedule_id])
  end
  
  def create
    @schedule = Schedule.find(params[:schedule_id])
    @spot = Spot.new(spot_params)
    @spot.schedule_id = @schedule.id
    if @spot.save
      redirect_to request.referer
    else
      @user = User.find(current_user.id)
      render request.referer
    end
  end
  
  def destroy
  end
  
  private
  
  def schedule_params
    params.require(:spot).permit(:day)
  end
  
end
