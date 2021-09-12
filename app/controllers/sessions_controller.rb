class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to authorized_path
    else
        redirect_to welcome_path, danger: "Username/Password not found"
    end
  end

  def welcome
  end

  def page_requires_login
  end

  def password_reset
  end
end
