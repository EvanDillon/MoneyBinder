class UsersController < ApplicationController
  # will bypass :authorized which will allow the user login/signup
  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:username, :password))
    if !@user.id.nil?
      session[:user_id] = @user.id
      redirect_to '/authorized'
    else
      redirect_to '/users/new', danger: "Username has already been taken"
    end
  end
end
