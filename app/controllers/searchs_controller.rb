class SearchsController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @user = User.find(current_user.id)
    @tags = Tag.all
  end
  
end
