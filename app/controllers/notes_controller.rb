class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @notes = Note.where(posted: true, status: 0).order(created_at: :desc).includes(:user, :spots, :tags).page(params[:page]).per(3)
    @tags = Tag.all.order(created_at: :desc)
  end
  
  def draft
    @user = User.find(current_user.id)
    @user_notes = Note.find_by(user_id: current_user.id)
    @notes = current_user.notes.where(posted: false).order(created_at: :desc)
    @user_notes = Note.includes(:tags).where(user_id: @user.id).all
  end

  def show
    @note = Note.includes(:tags).find(params[:id])
    @note_comment = NoteComment.new
    @user = User.find(@note.user_id)
    @user_notes = Note.includes(:tags).where(user_id: @user.id).all
  end

  def new
    @note = Note.new
    @user = User.find(current_user.id)
    @user_notes = Note.includes(:tags).where(user_id: @user.id).all
  end

  def create
    @user = User.find(current_user.id)
    @note = current_user.notes.new(note_params)
    tag_list = params[:note][:tag_name].split(/[[:blank:]]+/)
    if @note.save
      # save_tagはnote.rbにて定義
      @note.save_tag(tag_list)
      redirect_to  new_note_spot_path(note_id: @note.id)
    else
      flash[:alert] = "必要事項を追加してください"
      @user = User.find(current_user.id)
      @user_notes = Note.includes(:tags).where(user_id: @user.id).all
      render 'new'
    end
  end

  def edit
    @note = Note.find(params[:id])
    @user = User.find(@note.user_id)
    @user_notes = Note.includes(:tags).where(user_id: @user.id).all
    @tag_list = @note.tags.pluck(:tag_name).join(" ")
    if @note.user == current_user
      render 'edit'
    else
      redirect_to note_path(@note)
    end
  end

  def update
    @note = Note.find(params[:id])
    tag_list = params[:note][:tag_name].split(/[[:blank:]]+/)
    if @note.update(note_params)
      @note.save_tag(tag_list)
      redirect_to  new_note_spot_path(note_id: @note.id)
    else
      @user = User.find(current_user.id)
      @user_notes = Note.includes(:tags).where(user_id: @user.id).all
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
