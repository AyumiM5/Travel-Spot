class UsersController < ApplicationController
  before_action :authenticate_user!

  def mypage
    @user = User.find(current_user.id)
    @user_notes = Note.user_notes_tag(@user)
    @notes = current_user.notes.private_public_note.page(params[:page]).per(4)
  end

  def show
    @user = User.find_by(name: params[:name])
    @user_notes = Note.user_notes_tag(@user)
    @notes = @user.notes.public_note.page(params[:page]).per(4)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = 'プロフィールが変更されました'
      redirect_to mypage_path
    else
      render 'edit'
    end
  end

  def withdraw
    current_user.update(users_status: true)
    reset_session
    flash[:notice] = 'ありがとうございました。またのご利用を心よりお待ちしております。'
    redirect_to root_path
  end

  def favorite
    @user = User.find(current_user.id)
    favorites = Favorite.where(user_id: @user.id).pluck(:note_id)
    @favorites_notes = Note.includes(:user, :tags).find(favorites)
    @user_notes = Note.includes(:tags).where(user_id: @user.id).all
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
