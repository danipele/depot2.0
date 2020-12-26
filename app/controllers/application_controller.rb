class ApplicationController < ActionController::Base
  before_action :authorize, :set_i18n_locale_from_params
  protect_from_forgery with: :exception

  def authorize
    return if User.find_by(id: session[:user_id])

    if User.count.zero?
      redirect_to new_user_url, notice: 'Create first user'
    else
      redirect_to login_url, notice: 'Please log in'
    end
  end

  protected

  def set_i18n_locale_from_params
    return unless params[:locale]

    if I18n.available_locales.map(&:to_s).include?(params[:locale])
      I18n.locale = params[:locale]
    else
      flash.now[:notice] = "#{params[:locale]} translation not available"
      logger.error flash.now[:notice]
    end
  end
end
