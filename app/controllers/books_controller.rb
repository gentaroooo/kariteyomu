class BooksController < ApplicationController
  def index
    @books = Book.all.includes(:user).order(created_at: :desc)
  end

  def new
    @book = Book.new
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to books_path, success: t('defaults.message.created', item: Book.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Book.model_name.human)
      render :new
    end
  end

  def show
    @book = Book.find(params[:id])
    @comment = Comment.new
    @comments = @book.comments.includes(:user).order(created_at: :desc)
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :book_image, :book_image_cache)
  end
end
