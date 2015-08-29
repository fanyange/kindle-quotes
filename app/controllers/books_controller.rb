class BooksController < ApplicationController
  def index
    @books = Book.includes(:quotes).order('quotes.created_at desc')
  end
  def show
    @book = Book.find(params[:id])
  end
  def destroy
    Book.find(params[:id]).destroy
    redirect_to root_path
  end
end
