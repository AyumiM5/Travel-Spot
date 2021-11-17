class SearchsController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @tags = Tag.all
    @model = params[:model]
    @word = params[:word]
    if @model == 'user'
      @records = User.search_for(@word)
    elsif @model == 'note'
      @records = Note.search_for(@word)
    end
  end
  
end
