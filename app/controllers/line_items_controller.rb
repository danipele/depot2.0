class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: %i[create update destroy]
  before_action :set_line_item, only: %i[show edit update destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product_to_cart(product)
    session[:count_index_accessed] = 0
    respond_to do |format|
      if @line_item.save
        @current_item = @line_item
        format.html { redirect_to store_index_url }
        format.js { render file: 'carts/show.js.coffee' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    @line_item.quantity -= 1
    respond_to do |format|
      if @line_item.update(line_item_params)
        @current_item = @line_item
        format.js { render file: 'carts/show.js.coffee' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    @line_item.destroy
    respond_to do |format|
      format.js { render file: 'carts/show.js.coffee' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def line_item_params
    params.require(:line_item).permit(:product_id)
  end
end
