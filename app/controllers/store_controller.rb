class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def index
    @products = Product.order(:title)
    if session[:count_index_accessed].nil?
      session[:count_index_accessed] = 0
    else
      session[:count_index_accessed] += 1
    end
  end
end
