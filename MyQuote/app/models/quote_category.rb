class QuoteCategory < ApplicationRecord
  belongs_to :quote
  belongs_to :category

  validates :category_ids, presence: true
  validates :quote_id, presence: true
end
