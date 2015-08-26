class Quote < ActiveRecord::Base
  belongs_to :book
  validates :content,
    presence: true,
    not_included_before: true,
    not_include_before: true
end
