class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  helper_method :current_character

  def require_login
    if user = current_user
      if user.is_active
        return
      else
        user.reactivate
      end
    else
      redirect_to '/'
    end
  end

  def current_game
    @current_game ||= Game.find(params[:game_id]) if params[:game_id]
  end

  def require_is_player
    has_joined = current_user.games.all.include? current_game
    player = current_user.players.find_by(game_id: current_game.id)
    redirect_to game_path(@current_game) unless player.role == "player" and has_joined
  end

  def current_character
    @current_character ||= Character.find(params[:id]) if params[:id]
  end

  def require_character_owner
    game = current_character.player.game
    redirect_to game_path(game) unless current_user.players.all.include? current_character.player
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:account_update) << :username
  end
end
