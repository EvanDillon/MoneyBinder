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
    
    # If user/pass already exists the @user will not be created and it wil print the error message. 
    if !@user.id.nil?
      pass_check = valid_pass?(params[:user][:password])
      if pass_check.empty?
        session[:user_id] = @user.id
        redirect_to '/authorized'
      else
        redirect_to '/users/new', danger: "#{pass_check}"
      end
    else
      redirect_to '/users/new', danger: "#{@user.errors.full_messages.first}"
    end
  end

  private
  
  # Creates username for new user
  def create_username(fname, lname, accountCreated)
    if fname && lname && accountCreated
      user_name = "#{fname.first}#{lname}#{accountCreated.strftime("%m")}#{accountCreated.strftime("%y")}"
      return user_name
    else 
      return nil
    end 
  end

  def valid_pass?(pass)
    if pass.length >= 8 
      if pass.first.match?(/[[:alpha:]]/)
        if pass.match?(/[[:alpha:]]/) && pass.match?(/[[:digit:]]/) && pass.index( /[^[:alnum:]]/ ) != nil
          return ""
        else
          return "Password must have a letter, a number, and a special character. \n"
        end
      else 
        return "Password must start with a letter. \n"
      end
    else
      return "Password needs to be at least 8 characters. \n"
    end   
  end
end