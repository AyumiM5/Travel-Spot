class HomesController < ApplicationController
  
  def top 
    @notes = Note.includes(:user, :spots).where(posted: true, status: 0)
    @best_notes = @notes.best_note
  end

  def about
  end
  
end
