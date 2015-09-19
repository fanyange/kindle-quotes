require 'open-uri'

class Book < ActiveRecord::Base
  attr_accessor :douid

  has_many :quotes, dependent: :destroy
  validates :title, presence: true, uniqueness: true

  before_validation :fetch_douban_info

  private
  def fetch_douban_info
    title = self.title.split("(").first.strip if title
    if douid
      book_info = JSON.load(open "https://api.douban.com/v2/book/#{douid}")
      self.title = book_info["title"]
    else
      book_info = JSON.load(open "https://api.douban.com/v2/book/search?q=#{CGI.escape title}&count=1")["books"].first
    end
    self.author ||= book_info["author"].join(", ")
    self.description ||= book_info["summary"]
    self.image_url ||= book_info["images"]["small"]
    self.douban_url ||= book_info["alt"]
  end
end
