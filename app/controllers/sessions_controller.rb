class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new

  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to '/authorized'
    else
        redirect_to '/login', danger: "Username/Password not found"
    end
  end

  def login
  end

  def welcome
  end

  def page_requires_login
  end
end
