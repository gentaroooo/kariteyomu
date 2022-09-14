class BooksController < ApplicationController
  before_action :set_book, only: %i[edit update destroy]

  def index
    @books = Book.all.includes(:authors, :user).order(created_at: :desc)
  end

  def new
    @book = Book.new
    @volume_info = params[:volumeInfo]
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      @book.save_with_author(authors_params[:authors])
      redirect_to books_path, success: t('defaults.message.created', item: t('defaults.review'))
    else
      set_volume_info
      flash.now[:danger] = t('defaults.message.not_created', item: t('defaults.review'))
      render 'new'
    end
  end

  def show
    @book = Book.find(params[:id])
    @comment = Comment.new
    @comments = @book.comments.includes(:user).order(created_at: :desc)
  end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to @book, success: t('defaults.message.updated', item: Book.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Book.model_name.human)
      render :edit
    end
  end

  def destroy
    @book.destroy!
    redirect_to books_path, success: t('defaults.message.deleted', item: Book.model_name.human)
  end

  def search 
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

  private

  def book_params
    params.require(:book).permit(:title, :body, :image_link, :info_link, :published_date, :systemid)
  end

  def set_book
    @book = current_user.books.find(params[:id])
  end

  def authors_params
    params.require(:book).permit(authors: [])
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
