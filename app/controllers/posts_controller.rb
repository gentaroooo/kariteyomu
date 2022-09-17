class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
    @volume_info = params[:volumeInfo]
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      # @post.save_with_author(authors_params[:authors])
      redirect_to posts_path, success: t('.success')
    else
      set_volume_info
      flash.now[:danger] = t('.fail')
      render 'new'
    end
  end

  def show
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

      # if @google_books.present?
      #   @google_books['items']&.each do |google_book|
      #     if google_book['volumeInfo']['industryIdentifiers']&.select{|h| h["type"].include?("ISBN") }.present?
      #       @google_book_isbn = google_book['volumeInfo']['industryIdentifiers'].select{|h| h["type"].include?("ISBN") }.first["identifier"].to_i
      #     end
      #   end
      # end
      
      # appkey = "入力"

      # uri = URI.parse("https://api.calil.jp/check")

      # q = {appkey: appkey,
      #     isbn: @google_book_isbn,
      #     systemid: "Tokyo_Setagaya",
      #     callback: :no}

      # uri.query = URI.encode_www_form(q)
      # response = Net::HTTP.get_response(uri)

      # @hash = JSON.parse(response.body)["books"]["#{@google_book_isbn}"]["Tokyo_Setagaya"]["libkey"]
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image_link, :info_link, :published_date, :systemid)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def authors_params
    params.require(:post).permit(authors: [])
  end

  def set_volume_info
    @volume_info = {}
    @volume_info[:title] = params[:book][:title]
    @volume_info[:authors] = params[:book][:authors]
    @volume_info[:bookImage] = params[:book][:image_link]
    @volume_info[:infoLink] = params[:book][:info_link]
    @volume_info[:publishedDate] = params[:book][:published_date]
    @volume_info[:systemid] = params[:book][:systemid]
  end
end
