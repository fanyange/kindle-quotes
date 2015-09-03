class BooksController < ApplicationController
  def index
    @books = Book.includes(:quotes).order('quotes.created_at desc')
  end
  def show
    @book = Book.find(params[:id])
  end
  def edit
    @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    original_url = @book.image_url
    f = params[:book][:image]
    path = Rails.root.join('app', 'assets', 'images', f.original_filename)
    File.open(path, 'wb') { |file| file.write f.read }
    File.delete(File.join(File.dirname(path), original_url)) rescue puts "Not a Uploaded image"
    if @book.update(image_url: f.original_filename)
      redirect_to root_path
    else
      render 'edit'
    end
  end
  def destroy
    Book.find(params[:id]).destroy
    redirect_to root_path
  end
end
