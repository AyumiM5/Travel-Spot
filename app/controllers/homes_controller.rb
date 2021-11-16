class HomesController < ApplicationController
  
  def top 
    @notes = Note.where(posted: true, status: 0).limit(4).order(created_at: :desc)
    @best_notes = @notes.find(Favorite.group(:note_id).order('count(note_id) desc').limit(3).pluck(:note_id))
  end

  def about
  end
  
end
