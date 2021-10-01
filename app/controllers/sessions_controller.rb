class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:login, :welcome]

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) && @user.suspendedTill < Time.now && @user.active
      # Checks to see if the password is close to expiring (30 days)
      if remaining_days <= 0
        redirect_to welcome_path, warning: "Your password is expired. Please reset your password now."
      else
        session[:user_id] = @user.id
        @user.loginAttempts = 0
        @user.save
        #if remaining_days <= 3
        redirect_to homepage_path, warning: "Your password is going to expire in #{remaining_days} days. You can change your password in Profile Settings."
        #else
        #redirect_to homepage_path
        #end
      end
    elsif @user.nil?
      redirect_to welcome_path, danger: "Username not found"
    elsif @user
      if @user.active 
        # Checks if user is still suspended
        if @user.suspendedTill.nil? || @user.suspendedTill < Time.now
          # Checks how many attempts account has
          if @user.loginAttempts < 2
            @user.increment(:loginAttempts, 1) 
            @user.save
            redirect_to welcome_path, danger: "Incorrect Password (Attempts left: #{3 - @user.loginAttempts})"
          # Account has has 3 attempts so suspend for 1 min
          else
            @user.suspendedTill = Time.now + 1*60 
            @user.loginAttempts = 0
            @user.save
            redirect_to welcome_path, danger: "This account has been suspended for 1 min"
          end
        # Account is still suspended 
        else
          redirect_to welcome_path, danger: "This account is suspended for: #{(@user.suspendedTill - Time.now).round(0)}  sec"
        end
      else
        redirect_to welcome_path, danger: "This account is not active"
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

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end
end
