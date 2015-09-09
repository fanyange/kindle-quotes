class StaticPagesController < ApplicationController

  def quotes
    @quotes = Quote.order(created_at: :desc)
    render 'quotes/index'
  end

  def blog
  end

  def about
  end
end
