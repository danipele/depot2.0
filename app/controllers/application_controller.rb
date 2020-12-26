class ApplicationController < ActionController::Base
  before_action :authorize
  protect_from_forgery with: :exception

  def authorize
    return if User.find_by(id: session[:user_id])

    if User.count.zero?
      redirect_to new_user_url, notice: 'Create first user'
    else
      redirect_to login_url, notice: 'Please log in'
    end
  end
end
