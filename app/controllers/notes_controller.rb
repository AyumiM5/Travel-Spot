class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    @notes = Note.public_note_index.page(params[:page]).per(4)
    @tags = Tag.order(created_at: :desc).first(20)
  end

  def draft
    @user = User.find(current_user.id)
    @user_notes = Note.user_notes_tag(@user)
    @notes = current_user.notes.where(posted: false).page(params[:page]).per(4)
  end

  def show
    @note = Note.includes(:tags, :user).find(params[:id])
    @note_comment = NoteComment.new
    @user = User.find(@note.user_id)
    @user_notes = Note.user_notes_tag(@user)
    @note_comments = @note.note_comments.includes(:user).all
  end

  def new
    @note = Note.new
  end

  def create
    @user = User.find(current_user.id)
    @note = current_user.notes.new(note_params)
    tag_list = params[:note][:tag_name].split(/[[:blank:]]+/)
    if @note.save
      # save_tagはnote.rbにて定義
      @note.save_tag(tag_list)
      redirect_to new_note_spot_path(note_id: @note.id)
    else
      render 'new'
    end
  end

  def edit
    @note = Note.find(params[:id])
    @tag_list = @note.tags.pluck(:tag_name).join(' ')
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
      redirect_to note_path(@note)
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
    redirect_to mypage_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :stays, :body, :status, :image)
  end
end
