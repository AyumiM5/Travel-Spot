class HomesController < ApplicationController
  
  def top 
    @notes = Note.where(posted: true, status: 0).limit(3).order(created_at: :desc)
    @best_notes = @notes.find(Favorite.group(:note_id).order('count(note_id) desc').pluck(:note_id))
  end

  def about
  end
  
end
