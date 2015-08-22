class UsersController < ApplicationController
  before_action :require_login
  def show
    @user = User.find(params[:id])
  end

  def set_inactive
    @user = User.find(params[:id])
    @user.deactivate
    sign_out @user
    redirect_to '/'
  end
end
