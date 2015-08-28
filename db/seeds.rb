# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

content = File.read('/Users/maorui/Downloads/My Clippings.txt')
content.encode(content.encoding, universal_newline:true)
puts "open File..."
pattern = /(.*) \(([^()]+(?:\(.+\))?)\)\n- 您在位置 #(\d+)-(\d+)的标注 \| 添加于 (.+ .+)\n\n^(.+)$/
pattern2 = /(.*) \(([^()]+(?:\(.+\))?)\)\n- 您在位置 #(\d+) 的笔记 \| 添加于 (.+ .+)\n\n^(.+)$/

quotes_data = content.scan(pattern)
notes_data = content.scan(pattern2)

quotes_data.each do |quote_data|
  book_name, author, fst_char, lst_char, add_time, quotes = quote_data

  book_name = book_name[/\p{Word}.+$/].delete("\ufeff")
  add_time.sub! /星期./, ''
  add_time.sub! /下午/, "pm"
  add_time.sub! /上午/, "am"
  add_time = Time.strptime(add_time, "%Y年%m月%d日 %P%I:%M:%S")

  book = Book.create_with(author: author).find_or_create_by!(title: book_name)

  quote = book.quotes.build(content: quotes, created_at:add_time,  start_loc: fst_char, end_loc: lst_char)
  puts "Create new quote: #{quote.content[0,30]}" if quote.save
end

notes_data.each do |note_data|
  book_name, author, loc, add_time, notes = note_data
  book_name = book_name[/\p{Word}.+$/].delete("\ufeff")

  quote = Quote.joins(:book).where('title = ? and start_loc = ? or end_loc = ?', book_name, loc, loc).take
  puts "create note: #{notes}" if quote.update_attributes(notes: notes)
end
