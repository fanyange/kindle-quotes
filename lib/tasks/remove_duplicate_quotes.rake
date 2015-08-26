namespace :db do
  desc "remove quotes whose content is duplicate"
  task remove_duplicate_quotes: :environment do
    Quote.all.each do |quote|
      if (Quote.select(:content).where('content like ?', "%#{quote.content}%").ids - [quote.id]).any?
        puts "delete duplicate record with id: #{quote.id}"
        quote.destroy
      end
    end
  end
end
