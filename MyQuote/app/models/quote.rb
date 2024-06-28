class Quote < ApplicationRecord
  belongs_to :user
  belongs_to :philosopher
  
  attr_accessor :categoryname

  #has_many :quote_categories, dependent: :destroy
  has_and_belongs_to_many :categories, join_table: "quote_categories", foreign_key: "Quote_id", association_foreign_key: "Category_id"

  validates :quotetext, presence: true

  validates :category_ids, presence: true


  # Allow nested attributes for philosopher
  accepts_nested_attributes_for :philosopher
  accepts_nested_attributes_for :categories

end