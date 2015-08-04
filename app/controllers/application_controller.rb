class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_character

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def current_game
    @current_game ||= Game.find(params[:game_id]) if params[:game_id]
  end

  def require_playing
    redirect_to game_path(@current_game) unless current_user.games.map{ |g| g.id }.include? current_game.id
  end

  def current_character
    @current_character ||= Character.find(params[:id]) if params[:id]
  end

  def require_character_owner
    game = current_character.player.game
    redirect_to game_path(game) unless current_user.players.all.include? current_character.player
  end
end
