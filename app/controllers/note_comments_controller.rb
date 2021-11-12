class NoteCommentsController < ApplicationController
  
  def create
    note = Note.find(params[:note_id])
    comment = current_user.note_comments.new(note_comment_params)
    comment.note_id = note.id
    comment.save
    redirect_to note_path(note)
  end
  
  def destroy
  end
  
  private

  def note_params
    params.require(:note_comment).permit(:comment)
  end
  
end
