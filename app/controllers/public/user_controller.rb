class Public::UserController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(@user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id), notice: "プロフィールが更新されました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :birthday, :caption, :profile_image, :gender, :gameid, :device, :voicechat, :playstyle, :playtime)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "GuestUser"
      redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
