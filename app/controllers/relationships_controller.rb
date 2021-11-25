class RelationshipsController < ApplicationController
  def create
    @user = User.find_by(name: params[:user_name])
    current_user.follow(@user)
    @user.create_notification_follow(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_name])
    redirect_to request.referer
  end

  def followings
    @user = User.find_by(name: params[:user_name])
    @users = @user.following.page(params[:page]).per(6)
    @user_notes = Note.includes(:tags).where(user_id: @user.id).all
  end

  def followers
    @user = User.find_by(name: params[:user_name])
    @users = @user.followers.page(params[:page]).per(6)
    @user_notes = Note.includes(:tags).where(user_id: @user.id).all
  end
end
