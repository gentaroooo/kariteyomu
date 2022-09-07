class BooksController < ApplicationController
  def index
    @books = Book.all.includes(:user).order(created_at: :desc)
  end
end
