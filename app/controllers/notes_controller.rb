class NotesController < ApplicationController
  
  def index
    @user = User.find(current_user.id)
    @notes = Note.where(status: true, status: 0)
  end

  def show
    @note = Note.find(params[:id])
    @user = @note.user
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
  
  def edit
  end
  
  def update
  end
  
  def post
    note = Note.find(params[:id])
    note.update(posted: true)
    redirect_to note_path(note.id)
  end
  
  def destroy
    note = Note.find(params[:id])
    note.destroy
    redirect_to request.referer
  end
  
  private
  
  def note_params
    params.require(:note).permit(:title, :stays, :body, :status, :image)
  end
  
end
