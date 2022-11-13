class Admin::BooksController < Admin::BaseController
  before_action :set_book, only: %i[edit update show destroy]

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def edit; end

  def update
    if @book.update(book_params)
      redirect_to admin_book_path(@book), success: t('defaults.message.updated', item: Book.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_updated', item: Book.model_name.human)
      render :edit
    end
  end

  def show; end

  def destroy
    @book.destroy!
    redirect_to admin_books_path, success: t('defaults.message.deleted', item: Book.model_name.human)
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :body, :image_link, :info_link, :published_date, :systemid)
  end
end