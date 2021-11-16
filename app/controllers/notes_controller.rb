class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(current_user.id)
    @notes = Note.where(posted: true, status: 0).order(created_at: :desc)
  end

  def show
    @note = Note.find(params[:id])
    @user = @note.user
    @note_comment = NoteComment.new
  end

  def new
    @note = Note.new
    @user = User.find(current_user.id)
  end

  def create
    @user = User.find(current_user.id)
    @note = current_user.notes.new(note_params)
    tag_lists = params[:note][:tag_name].split(nil)
    if @note.save
      # save_tagはnote.rbにて定義
      @note.save_tag(tag_list)
      redirect_to  new_note_spot_path(note_id: @note.id)
    else
      flash[:alert] = "必要事項を追加してください"
      @user = User.find(current_user.id)
      render 'new'
    end
  end

  def edit
    @user = User.find(current_user.id)
    @note = Note.find(params[:id])
    @tag_list = @note.tags.pluck(:tag_name).split(nil)
    @spot = Spot.new
    if @note.user = current_user
      render 'edit'
    else
      redirect_to note_path(@note)
    end
  end

  def update
    note = Note.find(params[:id])
    tag_list = params[:note][:tag_name].split(nil)
    if note.update(note_params)
      note.save_tag(tag_list)
      redirect_to note_path(note)
    else
      render 'edit'
    end
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
