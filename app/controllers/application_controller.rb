class ApplicationController < ActionController::Base
  before_action :authorized
  helper_method :current_user
  helper_method :logged_in?

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
    ((current_user.passUpdatedAt + 30.days).to_date - Date.today).round
  end
=begin
  def password_expired?
    if remaining_days <= 0
      redirect_to homepage_path, warning: "Your password is expired. Please change your password now."
    else#if remaining_days <= 3
      redirect_to homepage_path, warning: "Your password is going to expire in: #{remaining_days}."
    end
  end
=end
end
