class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_parameters

  def set_parameters
    session[:style] = params[:style] if params[:style]
    @style = session[:style]

    unless params[:no_info].nil?
      session[:no_info] = params[:no_info] == 'true'
    end
    @no_info = session[:no_info]

    unless params[:no_animation].nil?
      session[:no_animation] = params[:no_animation] == 'true'
    end
    @no_animation = session[:no_animation]
  end
end
