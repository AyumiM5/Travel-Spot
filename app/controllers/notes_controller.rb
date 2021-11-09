class NotesController < ApplicationController
  def index
    @notes = Note.all
  end

  def show
  end

  def new
    @note = Note.new
    @user = User.find(current_user.id)
  end
  
  def create
    @user = User.find(current_user.id)
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    if @note.save
      redirect_to new_note_schedule_path(note_id: @note.id)
    else
      flash[:alert] = "必要事項を追加してください"
      @user = User.find(current_user.id)
      render 'new'
    end
  end
  
  private
  
  def note_params
    params.require(:note).permit(:title, :stays, :body, :status)
  end
  
end
