class NoteCommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @note = Note.find(params[:note_id])
    @note_comment = @note.note_comments.new(note_comment_params)
    @note_comment.user_id = current_user.id
    render 'error' unless @note_comment.save
    @note.save_notification_comment(current_user, @note_comment.id, @note.user_id)
  end
  
  def destroy
    @note = Note.find(params[:note_id])
    NoteComment.find(params[:id]).destroy
  end
  
  private

  def note_comment_params
    params.require(:note_comment).permit(:comment)
  end
  
end