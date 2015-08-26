class AddIndexToQuotesContent < ActiveRecord::Migration
  def change
    add_index :quotes, :content, unique: true
  end
end
