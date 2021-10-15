class ApplicationController < ActionController::Base
  include Pundit
  before_action :authorized
  helper_method :current_user
  helper_method :logged_in?
  helper_method :remaining_days

  add_flash_types :danger, :info, :warning, :success

  def current_user    
    User.find_by(id: session[:user_id])  
  end

  def logged_in?
    !current_user.nil?  
  end

  def authorized
    redirect_to welcome_path unless logged_in?
  end

  def remaining_days
    30 - (Date.today - ((@user.passUpdatedAt).to_date)).round
  end
end
