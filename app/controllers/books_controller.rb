class BooksController < ApplicationController
  def index
    @books = Book.includes(:quotes)
  end
  def show
    @book = Book.find(params[:id])
  end
end
