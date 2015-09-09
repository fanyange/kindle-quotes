class QuotesController < ApplicationController
  def index
    if params[:book_id]
      @book = Book.find(params[:book_id])
      @quotes = @book.quotes.order(:start_loc)
    else
      @quotes = Quote.all
    end
  end
end
