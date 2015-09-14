require "open-uri"

module BooksHelper
  def frequency_data
    # query = "select date, title as favorite, max(count) as max_count, sum(count) as sum_count from (select Date(quotes.created_at) as date, count(*) as count, title from quotes INNER JOIN books ON books.id = quotes.book_id group by Date(quotes.created_at), book_id) group by date;"

    count_quotes_by_day_and_book = "create temp view s1 as select Date(quotes.created_at) as date, count(*) as count, title from quotes INNER JOIN books ON books.id = quotes.book_id group by Date(quotes.created_at), title"
    max_and_sum_quotes_count_by_day = "create temp view s2 as select date, max(count) as max_count, sum(count) as sum_count from s1 group by date"
    query = "select s1.date,  max_count, sum_count from s2 inner join s1 on s2.date = s1.date and s2.max_count = s1.count"

    Quote.connection.select_all(count_quotes_by_day_and_book)
    Quote.connection.select_all(max_and_sum_quotes_count_by_day)
    Quote.connection.select_all(query)
  end
end
