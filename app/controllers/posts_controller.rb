class PostsController < ApplicationController
  def index
    @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page])
  end
end
