class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[edit update show destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to admin_post_path(@post), success: t('defaults.message.updated', item: Post.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Post.model_name.human)
      render :edit
    end
  end

  def show; end

  def destroy
    @post.destroy!
    redirect_to admin_posts_path, success: t('defaults.message.deleted', item: Post.model_name.human)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :image_link, :info_link, :published_date, :systemid, category_ids: [], age_ids: [])
  end
end