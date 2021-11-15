class HomesController < ApplicationController
  
  def top 
    @notes = Note.where(posted: true, status: 0).limit(4)
  end

  def about
  end
  
end
