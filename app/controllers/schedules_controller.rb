class SchedulesController < ApplicationController
  
  def new
    @user = User.find(current_user.id)
    @note = Note.order(updated_at: :desc).limit(1)
    @schedule = Schedule.new
    @schedules = Schedule.where(note_id: @note).order("created_at ASC")
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
  end
  
  private
  
  def schedule_params
    params.require(:schedule).permit(:day)
  end

end
