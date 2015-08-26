require "open-uri"

module BooksHelper
  def image_for(book)
    image_url = book.image_url
    douban_url = book.douban_url
    unless image_url and douban_url
      title = book.title.split("(").first.strip
      book_info = JSON.load(open "https://api.douban.com/v2/book/search?q=#{CGI.escape title}&count=1")["books"].first
      image_url = book_info["images"]["small"] if book_info
      douban_url = book_info["alt"]
      book.update_attributes(image_url: image_url, douban_url: douban_url)
    end
    link_to image_tag(image_url), douban_url
  end
end
