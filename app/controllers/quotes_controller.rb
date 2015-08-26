class QuotesController < ApplicationController
  def index
    @book = Book.find(params[:book_id])
    @quotes = @book.quotes.order(:start_loc)
  end
end
