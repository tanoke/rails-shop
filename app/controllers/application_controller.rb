class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order
  # def current_user
  #   # binding.
  # end
  # helper_method :current_user

  def authorize
    redirect_to login_path unless current_user
  end

  def authorize_frontend
    redirect_to post_fr_login_path unless current_user
  end

  def require_admin
    redirect_to login_path unless current_user.admin?
  end

  def current_order
    if !session[:order_id].nil?
      Order.find(session[:order_id])
    else
      Order.new
    end
  end
end
