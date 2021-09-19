class PasswordController < ApplicationController
  skip_before_action :authorized
  
  def reset
    token = request.query_parameters['token'] 
    if token.nil? 
      token = params['token'] or not_found
    end

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
        redirect_back fallback_location: root_path, danger: "Please choose a password you have not used before"
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
        ResetMailer.with(user: @user).reset_password.deliver_later
      end
      render plain: "A link has been sent to your email to reset your password (#{token})"
    end
  end

  def not_found
    raise ActionController::RoutingError new('Not Found')
  end
end
