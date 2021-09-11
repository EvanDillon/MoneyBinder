class UsersController < ApplicationController
  # will bypass :authorized which will allow the user login/signup
  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    user_name = create_username(params[:user][:firstName], params[:user][:lastName], Time.zone.now)
    @user = User.create(
                firstName: "#{params[:user][:firstName]}",
                lastName: "#{params[:user][:lastName]}",
                username: "#{user_name}",
                password: "#{params[:user][:password]}",
                address: "#{params[:user][:address]}",
                email: "#{params[:user][:email]}",
                phoneNum: "#{params[:user][:phoneNum]}",
                dob: "#{params[:user][:dob]}",
                userType: "#{params[:user][:userType]}",
            )
    
    if !@user.id.nil?
      session[:user_id] = @user.id
      redirect_to '/authorized'
    else
      redirect_to '/users/new', danger: "Username has already been taken"
    end
  end

  private
  def create_username(fname, lname, accountCreated)
    if fname && lname && accountCreated
      user_name = "#{fname.first}#{lname}#{accountCreated.strftime("%m")}#{accountCreated.strftime("%y")}"
      return user_name
    else 
      return nil
    end 
  end
end
