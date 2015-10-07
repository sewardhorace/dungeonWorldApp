class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  helper_method :current_game

  def require_login
    if user = current_user
      if user.reactivate
        return
      end
    else
      redirect_to '/'
    end
  end

  def current_game
    @current_game ||= Game.find(params[:game_id]) if params[:game_id]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end
end
