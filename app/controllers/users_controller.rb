class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_user, only: %i[show following follower show_post show_book]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to login_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new
    end
  end

  def index
    @users = User.all.includes([:posts, :active_relationships, :passive_relationships]).order(id: :desc).page(params[:page])
  end

  def show
    @posts = @user.posts.page(params[:page])
    @books = @user.books.page(params[:page])
  end

  def show_post
    @posts = @user.posts.page(params[:page])
  end

  def show_book
    @books = @user.posts.page(params[:page])
  end

  def following
    @users = @user.followings.page(params[:page]).per(4)
  end

  def follower
    @users = @user.followers.page(params[:page]).per(4)
  end
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def set_user
    @user = User.find(params[:id])
  end
end