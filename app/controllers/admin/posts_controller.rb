class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  def index
    # @q = Post.ransack(params[:q])
    @posts = Post.all.includes([:user, :authors, :categories, :likes, :ages]).order(created_at: :desc).page(params[:page]).per(6)
  end

  def new
    @post = Post.new
    @volume_info = params[:volumeInfo]
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save_with_author(authors_params[:authors])
      redirect_to posts_path, success: t('.success')
    else
      set_volume_info
      flash.now[:danger] = t('.fail')
      render 'new'
    end
  end

  def show
    @book = Book.new
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, success: t('defaults.message.updated', item: Post.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Post.model_name.human)
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, success: t('defaults.message.deleted', item: Post.model_name.human)
  end

  def search 
    @post = Post.new
    @volume_info = params[:volumeInfo]
    
    if params[:search].nil?
      return
    elsif params[:search].blank?
      flash.now[:danger] = '検索キーワードが入力されていません'
      return
    else
      url = "https://www.googleapis.com/books/v1/volumes"
      text = params[:search]
      res = Faraday.get(url, q: text, langRestrict: 'ja', maxResults: 30)
      @google_books = JSON.parse(res.body)
    end
  end

  def likes
    @like_posts = current_user.like_posts.includes([:user, :authors, :categories, :likes]).order(created_at: :desc).page(params[:page])
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image_link, :info_link, :published_date, :systemid, category_ids: [], age_ids: [])
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def authors_params
    if params.dig(:book).nil?
      params.permit(authors: ['著者不明'])
    else
      params.require(:book).permit(authors: [])
    end       
  end

  def set_volume_info
    @volume_info = {}
    @volume_info[:title] = params[:post][:title]
    @volume_info[:authors] = params[:post][:authors]
    @volume_info[:bookImage] = params[:post][:image_link]
    @volume_info[:canonicalVolumeLink] = params[:post][:info_link]
    @volume_info[:publishedDate] = params[:post][:published_date]
    @volume_info[:systemid] = params[:post][:systemid]
  end
end
