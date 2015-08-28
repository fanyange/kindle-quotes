class Quote < ActiveRecord::Base
  belongs_to :book
  validates :content,
    not_included_before: true, on: :create
  validates :content,
    presence: true
  before_create :destroy_subcontent_quotes

  private
  def destroy_subcontent_quotes
    Quote.where("instr(?, content) = 1", self.content).destroy_all
  end
end 
