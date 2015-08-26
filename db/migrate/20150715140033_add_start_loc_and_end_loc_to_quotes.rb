class AddStartLocAndEndLocToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :start_loc, :integer
    add_column :quotes, :end_loc, :integer
  end
end
