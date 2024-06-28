class HomeController < ApplicationController
  # This controller was made using the workshop materials 


  # This section is responsible for displaying the 5 most recent quotes on the home page of the app 
  def index
    @quotes = Quote.includes(:philosopher).where(is_public: true).order(created_at: :desc).limit(5) 
  end
  
  # This section is responsible for displaying all of the logged in user's quotes under the "My Quotes" tab
  def uquotes
    @quotes = Quote.includes(:philosopher).where(user_id: session[:user_id])
  end
  
end 