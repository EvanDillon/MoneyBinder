class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome, :password_reset]

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to homepage_path
    else
      redirect_to welcome_path, danger: "Username/Password not found"
    end
  end

  def welcome
  end

  def homepage
  end

  def password_reset
    @user_email = params[:email]
  end
end
