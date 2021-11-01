class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:login, :welcome, :sign_up, :process_new_sign_up]
  
  rescue_from Pundit::NotAuthorizedError do 
    redirect_to error_path
  end

  def login
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password]) && @user.suspendedTill < Time.now && @user.active
      # Checks to see if the password is close to expiring (30 days)
      if remaining_days <= 0
        redirect_to welcome_path, warning: ErrorMessage.find_by(error_name: "user_expired_password").body
      else
        session[:user_id] = @user.id
        @user.loginAttempts = 0
        @user.save
        if remaining_days <= 3
        redirect_to homepage_path, warning: "#{ErrorMessage.find_by(error_name: "user_almost_expired_password_part1").body} #{remaining_days} #{ErrorMessage.find_by(error_name: "user_almost_expired_password_part2").body}"
        else
        redirect_to homepage_path
        end
      end
    elsif @user.nil?
      redirect_to welcome_path, danger: ErrorMessage.find_by(error_name: "user_not_found").body
    elsif @user
      if @user.active 
        # Checks if user is still suspended
        if @user.suspendedTill.nil? || @user.suspendedTill < Time.now
          # Checks how many attempts account has
          if @user.loginAttempts < 2
            @user.increment(:loginAttempts, 1) 
            @user.save
            redirect_to welcome_path, danger: "#{ErrorMessage.find_by(error_name: "user_incorrect_password_part1").body} #{3 - @user.loginAttempts}#{ErrorMessage.find_by(error_name: "user_incorrect_password_part2").body}"
          # Account has has 3 attempts so suspend for 1 min
          else
            @user.suspendedTill = Time.now + 1*60 
            @user.loginAttempts = 0
            @user.save
            redirect_to welcome_path, danger: ErrorMessage.find_by(error_name: "user_suspended").body
          end
        # Account is still suspended 
        else
          redirect_to welcome_path, danger: "#{ErrorMessage.find_by(error_name: "user_suspended_until").body} #{@user.suspendedTill.strftime("%B%e, %Y %I:%M %p")} "
        end
      else
        redirect_to welcome_path, danger: ErrorMessage.find_by(error_name: "user_inactive").body
      end
    end
  end

  def welcome
  end

  def homepage
  end

  def sign_up
    @user = User.new
  end

  def process_new_sign_up
    user_name = User.create_username(params[:firstName], params[:lastName], Time.zone.now)
    pass_check = User.valid_pass?(params[:password])
    password_update = Time.now

    if pass_check.empty? && !user_name.nil?
      @user = User.new(user_params)
      @user.username = user_name
      @user.passUpdatedAt = password_update

      if @user.save 
        # If user created is an admin log them in
        if @user.userType == 1
          initialize_security_question(@user, params[:security_question_1][:id], params[:security_question_answer])
          session[:user_id] = @user.id
          redirect_to '/homepage'
  
         # If new user is manager/accountant send an email to admin to approve
        else
          @user.active = false
          @user.save
          initialize_security_question(@user, params[:security_question_1][:id], params[:security_question_answer])
          ResetMailer.with(user: @user).approve_new_account.deliver_now
          redirect_to welcome_path, success: ErrorMessage.find_by(error_name: "user_create_request").body
        end      
      else 
        redirect_to sign_up_path, danger: "#{@user.errors.full_messages.first}"
      end
    else
      redirect_to sign_up_path, danger: "#{pass_check}"
    end
  end

  def user_management
    authorize current_user, :user_admin?
    @all_users = User.all
  end

  def journal
  end

  def help_index
  end

  def user_management_help
  end

  def sign_in_help
  end

  def event_logs_help
  end

  def expired_passwords
    authorize current_user, :user_admin?
    @all_users = User.all
  end

  def send_message
    @all_users = User.all
  end

  def trial_balance
    # @accounts = Account.all
    @non_zero_accounts = Account.where('balance != ?', 0 )
    @debit_total = @non_zero_accounts.where(normal_side: "Debit").pluck(:balance).map(&:abs).sum
    @credit_total = @non_zero_accounts.where(normal_side: "Credit").pluck(:balance).map(&:abs).sum
  end

  def balance_sheet
    @non_zero_accounts = Account.where('balance != ?', 0 )
    
    @current_assets = @non_zero_accounts.where(category: "Asset").where.not(account_number: [188, 181])
    @equipment_assets = @non_zero_accounts.where(account_number: [188, 181]) # Only Office Equipment and Accumulated Depreciation accounts
    @total_current_assets = @current_assets.pluck(:balance).sum
    @total_equipment_assets = @equipment_assets.pluck(:balance).sum

    @total_assets = @total_current_assets + @total_equipment_assets

    @liability_accounts = @non_zero_accounts.where(name: ["Accounts Payable", "Salaries Payable", "Unearned Revenue"])
    @total_liabilities = @liability_accounts.pluck(:balance).sum
    @equity_accounts = @non_zero_accounts.where(name: ["Contributed Capital", "Retained Earnings"])
    @total_equity = @equity_accounts.pluck(:balance).sum

    @total_l_and_e = @total_liabilities + @total_equity
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end

  def error
  end

  private

  def user_params
    params.permit(:firstName, :lastName, :user_name, :password, :address, :email, :phoneNum, :dob, :userType, :active)    
  end

  def initialize_security_question(user, question_id, answer)
    PasswordAuthorization.create(user_id: user.id, security_question_id: question_id.to_i, answer: answer)
  end
end
