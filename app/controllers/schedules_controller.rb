class SchedulesController < ApplicationController
  
  def new
    @user = User.find(current_user.id)
    @note = Note.find(params[:note_id])
    @schedule = Schedule.new
    @schedules = Schedule.where(note_id: @note).order("created_at ASC")
    @spot = Spot.new
  end
  
  def create
    @note = Note.find(params[:note_id])
    @schedule = Schedule.new(schedule_params)
    @schedule.note_id = @note.id
    if @schedule.save
      redirect_to request.referer
    else
      @user = User.find(current_user.id)
      render "new"
    end
  end
  
  def destroy
    schedule = Schedule.find(params[:id])
    schedule.destroy
    redirect_to request.referer
  end
  
  private
  
  def schedule_params
    params.require(:schedule).permit(:day)
  end

end
