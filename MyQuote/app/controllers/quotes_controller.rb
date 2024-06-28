class QuotesController < ApplicationController
  # This controller was made using the workshop materials 

  before_action :set_quote, only: %i[ show edit update destroy ]
  before_action :require_login, except: [:index, :show]

  
  # GET /quotes or /quotes.json
  def index
    @quotes = Quote.where(is_public: true) # This shows only the quotes which are public on the home page 
  end

  # GET /quotes/1 or /quotes/1.json
  def show
    @quote = Quote.find(params[:id])

    if !(@quote.is_public) && (@quote.user != current_user) # This prevents unauthorised users from viewing quotes that are private
      redirect_to root_path, alert: "You don't have permission to view this quote."
    end
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
    @quote.build_philosopher
  end

  # GET /quotes/1/edit
  def edit
    @quote = Quote.find(params[:id])

    unless current_user == @quote.user # This prevents unauthorised users from editing quotes
      redirect_to root_path, alert: "You don't have permission to edit this quote."
    end
  end

  # POST /quotes or /quotes.json
  def create
    @quote = Quote.new(quote_params)
    category_name = params[:quote][:categoryname]
    category = nil

    if category_name.present? # This allows a category to be saved to the quote
      category = Category.find_or_create_by(categoryname: category_name)
      @quote.categories << category
    end

    respond_to do |format|
      if @quote.save
        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully created." }
        format.json { render :show, status: :created, location: @quote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotes/1 or /quotes/1.json
  def update

    unless current_user == @quote.user # This prevents unauthorised users from editing quotes
      redirect_to root_path, alert: "You don't have permission to edit this quote."
      return
    end

    respond_to do |format|
      if @quote.update(quote_params)
        @quote.categories.clear

        category_name = params[:quote][:categoryname] # This allows a category to be updated and saved to the quote
        if category_name.present?
          category = Category.find_or_create_by(categoryname: category_name)
          @quote.categories << category
        end

        format.html { redirect_to quote_url(@quote), notice: "Quote was successfully updated." }
        format.json { render :show, status: :ok, location: @quote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotes/1 or /quotes/1.json
  def destroy
    
    @quote = Quote.find(params[:id])

    unless current_user == @quote.user # This prevents unauthorised users from deleting quotes
      redirect_to root_path, alert: "You don't have permission to delete this quote."
      return
    end

    @quote.destroy

    respond_to do |format|
      format.html { redirect_to quotes_url, notice: "Quote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # This uses callbacks to share common setups or constraints between actions.
  def set_quote
     @quote = Quote.find(params[:id])
  end

  # Only allows a list of trusted parameters through.
  def quote_params
    params.require(:quote).permit(:quotetext, :comment, :is_public, :publicationyear, :user_id, :philosopher_id, :categoryname, philosopher_attributes: [:pfname, :plname, :pbiography, :pdob, :pdod])
  end
end
