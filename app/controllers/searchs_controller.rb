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
  
  def tag_search
    @tags = Tag.all
    @tag = Tag.find_by(tag_name: params[:tag_name])
    @notes = @tag.notes.where(posted: true, status: 0).order(created_at: :desc)
  end
  
end
