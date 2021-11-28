class PasswordController < ApplicationController
  skip_before_action :authorized
  
  def reset
    token = request.query_parameters['token'] 
    if token.nil? 
      token = params['token'] or not_found
    end
    
    # @correct_answer = true
    # if @correct_answer
    #   redirect_back fallback_location: root_path, success: "Correct answer"
    # elsif @correct_answer == false
    #   redirect_back fallback_location: root_path, danger: "Incorrect answer"
    # end

    @user = User.find_by_reset(token) or not_found  
    if params['password']
      # Checks if user is entering same password
      same_pass = @user.authenticate(params['password'])
      pass_errors = User.valid_pass?(params['password'])
      if pass_errors.empty? && !same_pass
        @user.password = params['password']
        @user.reset = nil
        @user.save
        render plain: "Successfully reset password for #{@user.username}"
      elsif same_pass 
        redirect_back fallback_location: root_path, danger: ErrorMessage.find_by(error_name: "user_used_password").body
      elsif !pass_errors.empty?
        redirect_back fallback_location: root_path, danger: "#{pass_errors}"
      end
    end
  end

  def forgot
    if params[:email]
      @user = User.find_by_email(params[:email])
      if @user
        token = SecureRandom.hex(10)
        @user.reset = token
        @user.save
        ResetMailer.with(user: @user).reset_password.deliver_now
      end
      redirect_to welcome_path, success: ErrorMessage.find_by(error_name: "user_reset_password").body
      # render plain: "A link has been sent to your email to reset your password \n http://localhost:3000/password/reset?token=#{token}"
    end
  end


  # Could not get this to work
  def check_answer
    if params[:security_question_answer]
      @user = User.find_by_reset(params[:token])  
      if User.find(@user.id).password_join_authorization.pluck(:answer).first == params[:security_question_answer]
        return true
      else
        return false
      end
    else 
      return nil
    end
  end

  def not_found
    raise ActionController::RoutingError new('Not Found')
  end
end
