class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_style

  def set_style
    session[:style] = params[:style] if params[:style]
    @style = session[:style]
  end
end
