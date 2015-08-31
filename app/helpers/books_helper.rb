require "open-uri"

module BooksHelper
  def frequency_data
    query = "select date, title as favorite, max(count) as max_count, sum(count) as sum_count from (select Date(quotes.created_at) as date, count(*) as count, title from quotes INNER JOIN books ON books.id = quotes.book_id group by Date(quotes.created_at), book_id) group by date;"
    Quote.connection.select_all(query)
  end
end
