class SearchController < ApplicationController
  # This controller was made using workshop materials

  def index
    if params[:category_query].present? # This section allows the search bar to function by querying categories
      category_id = params[:category_query][:id]
      if category_id.present?
        @category = Category.find(category_id)
        @quotes = @category.quotes.where(is_public: true) # This section filter out the private quotes
      end
    end
  end
end