class NotesController < ApplicationController
  def index
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
    @note.user_id = current_user
    if @note.save
      redirect_to mypage_path
    else
      render "create"
    end
  end

  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
  def note_params
    params.require(:note).permit(:title, :stays, :body, :status)
  end
  
end
