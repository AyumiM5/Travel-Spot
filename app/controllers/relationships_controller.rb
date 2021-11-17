class RelationshipsController < ApplicationController
  
  def create
    current_user.follow(params[:user_name])
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_name])
    redirect_to request.referer  
  end
  
  def followings
    @user = User.find_by(name: params[:user_name])
    @users = @user.following
  end

  def followers
    @user = User.find_by(name: params[:user_name])
    @users = @user.followers
  end
  
end