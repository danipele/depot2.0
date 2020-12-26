class StoreController < ApplicationController
  include CurrentCart
  before_action :set_cart
  skip_before_action :authorize

  def index
    if params[:set_locale]
      redirect_to store_index_url(locale: params[:set_locale])
    else
      @products = Product.order(:title).where(locale: I18n.locale)
      if session[:count_index_accessed].nil?
        session[:count_index_accessed] = 0
      else
        session[:count_index_accessed] += 1
      end
    end
  end
end
