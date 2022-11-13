class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).includes([:posts, :active_relationships, :passive_relationships]).order(id: :desc).page(params[:page])
  end

  def edit; end

  def new
    @user = User.new
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), success: t('defaults.message.updated', item: User.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: User.model_name.human)
      render :edit
    end
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

  def set_user
    @user = User.find(params[:id])
  end
  
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
