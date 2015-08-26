class AddDoubanUrlToBooks < ActiveRecord::Migration
  def change
    add_column :books, :douban_url, :string
  end
end
