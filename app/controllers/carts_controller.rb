class CartsController < ApplicationController
  before_action :set_cart, only: %i[show edit update destroy]
  before_action :ensure_session_cart, only: [:show]
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  # GET /carts
  # GET /carts.json
  def index
    @carts = Cart.all
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit; end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy if @cart.id == session[:cart_id]
    session[:cart_id] = nil
    respond_to do |format|
      format.js { render :show }
    end
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart #{params[:id]}"
    redirect_to store_index_url, notice: 'Invalid cart'
  end

  def ensure_session_cart
    return unless params[:id].to_i != session[:cart_id]

    respond_to do |format|
      format.html { redirect_to store_index_url, notice: 'Cart unavailable.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_cart
    @cart = Cart.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def cart_params
    params.fetch(:cart, {})
  end
end
