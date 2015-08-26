class AddNotesToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :notes, :text
  end
end
