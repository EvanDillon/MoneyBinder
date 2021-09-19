class UsersController < ApplicationController
  # will bypass :authorized which will allow the user login/signup
  skip_before_action :authorized, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    user_name = create_username(params[:user][:firstName], params[:user][:lastName], Time.zone.now)
    pass_check = User.valid_pass?(params[:user][:password])

    if pass_check.empty? && !user_name.nil?
      @user = User.new(user_params)
      @user.username = user_name
      if @user.save 
        session[:user_id] = @user.id
        redirect_to '/homepage'        
      else 
        redirect_to '/users/new', danger: "#{@user.errors.full_messages.first}"
      end
    else
      redirect_to '/users/new', danger: "#{pass_check}"
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstName, :lastName, :user_name, :password, :address, :email, :phoneNum, :dob, :userType)    
  end
  
  # Creates username for new user
  def create_username(fname, lname, accountCreated)
    if fname && lname && accountCreated
      user_name = "#{fname.first}#{lname}#{accountCreated.strftime("%m")}#{accountCreated.strftime("%y")}"
      return user_name
    else 
      return nil
    end 
  end

  # def valid_pass?(pass)
  #   if pass.length >= 8 
  #     if pass.first.match?(/[[:alpha:]]/)
  #       if pass.match?(/[[:alpha:]]/) && pass.match?(/[[:digit:]]/) && pass.index( /[^[:alnum:]]/ ) != nil
  #         return ""
  #       else
  #         return "Password must have a letter, a number, and a special character. \n"
  #       end
  #     else 
  #       return "Password must start with a letter. \n"
  #     end
  #   else
  #     return "Password needs to be at least 8 characters. \n"
  #   end   
  # end
end