class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:login, :welcome]

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) && @user.suspendedTill < Time.now && @user.active
      # Checks to see if the password is close to expiring (30 days)
      if remaining_days <= 0
        redirect_to welcome_path, warning: ErrorMessage.find_by(error_name: "user_expired_password").body
      else
        session[:user_id] = @user.id
        @user.loginAttempts = 0
        @user.save
        if remaining_days <= 3
        redirect_to homepage_path, warning: "#{ErrorMessage.find_by(error_name: "user_almost_expired_password_part1").body} #{remaining_days} #{ErrorMessage.find_by(error_name: "user_almost_expired_password_part2").body}"
        else
        redirect_to homepage_path
        end
      end
    elsif @user.nil?
      redirect_to welcome_path, danger: ErrorMessage.find_by(error_name: "user_not_found").body
    elsif @user
      if @user.active 
        # Checks if user is still suspended
        if @user.suspendedTill.nil? || @user.suspendedTill < Time.now
          # Checks how many attempts account has
          if @user.loginAttempts < 2
            @user.increment(:loginAttempts, 1) 
            @user.save
            redirect_to welcome_path, danger: "#{ErrorMessage.find_by(error_name: "user_incorrect_password_part1").body} #{3 - @user.loginAttempts} #{ErrorMessage.find_by(error_name: "user_incorrect_password_part2").body}"
          # Account has has 3 attempts so suspend for 1 min
          else
            @user.suspendedTill = Time.now + 1*60 
            @user.loginAttempts = 0
            @user.save
            redirect_to welcome_path, danger: ErrorMessage.find_by(error_name: "user_suspended").body
          end
        # Account is still suspended 
        else
          redirect_to welcome_path, danger: "#{ErrorMessage.find_by(error_name: "user_suspended_until").body} #{@user.suspendedTill.strftime("%B%e, %Y %I:%M %p")} "
        end
      else
        redirect_to welcome_path, danger: ErrorMessage.find_by(error_name: "user_inactive").body
      end
    end
  end

  def welcome
  end

  def homepage
  end

  def create
    @user = User.new
  end

  def user_management
    @all_users = User.all
  end

  def expired_passwords
    @all_users = User.all
  end

  def send_message
    @all_users = User.all
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end
end
