class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
    @notes = current_user.notes.where(status: true)
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
      render "edit"
    end
  end
  
  def withdraw
    current_user.update(users_status: true)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end