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
        initialize_security_question(@user, params[:security_question_1][:id], params[:security_question_answer])
        session[:user_id] = @user.id
        redirect_to '/homepage'        
      else 
        redirect_to '/users/new', danger: "#{@user.errors.full_messages.first}"
      end
    else
      redirect_to '/users/new', danger: "#{pass_check}"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to user_management_path, success: "Account Deleted"
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    id = params[:user_id].to_i
    @user = User.find(id)
    userType = params[:userType].to_i
    if params[:active].nil?
      active = false
    else
      active = true
    end
    User.update(id, username: params[:username],firstName: params[:firstName], lastName: params[:lastName], email: params[:email], phoneNum: params[:phoneNum], address: params[:address], userType: userType, active: active)
    auth_id = @user.password_authorization_ids.first
    PasswordAuthorization.update(auth_id, answer: params[:security_question_answer])
    redirect_to user_management_path, success: "Account Updated"
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

  def initialize_security_question(user, question_id, answer)
    PasswordAuthorization.create(user_id: user.id, security_question_id: question_id.to_i, answer: answer)
  end
end