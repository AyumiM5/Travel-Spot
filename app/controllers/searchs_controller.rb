class SearchsController < ApplicationController
  before_action :authenticate_user!

  def search
    @tags = Tag.last(20).order(created_at: :desc)
    @model = params[:model]
    @word = params[:word]
    if @model == 'user'
      @records = User.search_for(@word).page(params[:page]).per(6)
    elsif @model == 'note'
      @records = Note.public_note.search_for(@word).page(params[:page]).per(3)
    end
  end

  def tag_search
    @tags = Tag.last(20).order(created_at: :desc)
    @tag = Tag.find_by(tag_name: params[:tag_name])
    @notes = @tag.notes.where(posted: true, status: 0).order(created_at: :desc)
  end
end
