class BooksController < ApplicationController

  # include ActionController::Live
  # force_ssl

  USERS = { "fanyange" => "zxTzq890806" }
  
  before_action -> { @book = Book.find(params[:id]) }, except: [:index, :showrequest]
  # before_action :authenticate

  def index
    @books = Book.includes(:quotes).order('quotes.created_at desc')
    respond_to do |format|
      format.html
      format.xml { render xml: @books }
      format.json { render json: @books }
    end
  end

  def update
    original_url = @book.image_url
    f = params[:book][:image]
    path = Rails.root.join('app', 'assets', 'images', f.original_filename)
    File.open(path, 'wb') { |file| file.write f.read }
    File.delete(File.join(File.dirname(path), original_url)) rescue puts "Not a Uploaded image"
    if @book.update(image_url: f.original_filename)
      flash[:info] = "You have successfully uploaded a image file."
      redirect_to root_path
    else
      flash.now[:error] = "Your uploading failed."
      render 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to root_path
  end

  def showrequest
    response.headers['Content-Type'] = 'text/event-stream'
    100.times do |i|
      response.stream.write "#{i+1} Hello World!\n"
      sleep 1
    end
  ensure
    response.stream.close
  end

  private

  def authenticate
    authenticate_or_request_with_http_digest do |username|
      USERS[username]
    end
  end
end
