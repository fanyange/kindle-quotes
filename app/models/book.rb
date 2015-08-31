require 'open-uri'

class Book < ActiveRecord::Base
  has_many :quotes, dependent: :destroy
  validates :title, presence: true, uniqueness: true

  before_save :fetch_douban_info

  private
  def fetch_douban_info
    if self.image_url.blank? or self.douban_url.blank?
      title = self.title.split("(").first.strip
      book_info = JSON.load(open "https://api.douban.com/v2/book/search?q=#{CGI.escape title}&count=1")["books"].first
      self.image_url = book_info["images"]["small"] if book_info
      self.douban_url = book_info["alt"]
    end
  end
end
