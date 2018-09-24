class ApplicationController < ActionController::Base
  before_action :set_current_user

  protected

  def current_user
    @current_user ||= Moviegoer.where(id: session[:user_id]).first
    # redirect_to login_path and return unless @current_user
  end

  alias set_current_user current_user
end
