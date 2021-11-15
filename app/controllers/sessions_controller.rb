class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:login, :welcome, :sign_up, :process_new_sign_up]
  before_action :stored_net_income, :only => [:income_statement, :retained_earnings]
  before_action :trial_balance,     :only => :homepage
  before_action :income_statement,  :only => :homepage
  before_action :retained_earnings, :only => :homepage
  before_action :balance_sheet,     :only => :homepage
  
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
    # Can access any variable in reports (such as the ones below) because of before_actions at the top.
    # Current ratio (current assets / total liabilites)
    if !@total_current_assets.zero? || !@total_liabilities.zero?
      current_ratio = ActionController::Base.helpers.number_with_precision((@total_current_assets / @total_liabilities), precision: 2, delimiter: ',').to_f
    else
      current_ratio = 0
    end

    # Asset Turnover ratio  (Net income / total assets)
    if !@net_income.zero? || !@total_assets.zero?
      asset_turnover_ratio = ActionController::Base.helpers.number_with_precision((@net_income / @total_assets), precision: 2, delimiter: ',').to_f
    else
      asset_turnover_ratio = 0
    end

    # Return on Equity Ratio (ROE)  (Net income / Shareholder equity)
    if !@net_income.zero? || !@total_equity.zero?
      reo_percentage = ActionController::Base.helpers.number_with_precision((@net_income / @total_equity)*100, precision: 1, delimiter: ',').to_f
    else
      reo_percentage = 0
    end

    current_ratio_gauge =         GoogleVisualr::Interactive::Gauge.new(  new_gauge(current_ratio),        get_ratio_options)
    asset_turnover_ratio_gauge =  GoogleVisualr::Interactive::Gauge.new(  new_gauge(asset_turnover_ratio), get_ratio_options)
    reo_percentage_gauge =        GoogleVisualr::Interactive::Gauge.new(  new_gauge(reo_percentage),       get_percentage_options)

    #                             Gauge:                        Value:                 Color:                                       Name:
    current_ratio_data =          [current_ratio_gauge,         current_ratio,        calculate_ratio_color(current_ratio),         "Current Ratio"]
    asset_turnover_ratio_data =   [asset_turnover_ratio_gauge,  asset_turnover_ratio, calculate_ratio_color(asset_turnover_ratio),  "Asset Turnover"]
    reo_percentage_data =         [reo_percentage_gauge,        reo_percentage,       calculate_percentage_color(reo_percentage),   "Return on Equity"]

    # Once you create a new gauge at to this array 
    @ratio_gauges = [current_ratio_data, asset_turnover_ratio_data]
    @percentage_gauges = [reo_percentage_data]
    @index = @ratio_gauges.count
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
    # authorize current_user, :user_not_admin?
    @non_zero_accounts = Account.where('balance != ?', 0)
    @debit_total = @non_zero_accounts.where(normal_side: "Debit").pluck(:balance).map(&:abs).sum
    @credit_total = @non_zero_accounts.where(normal_side: "Credit").pluck(:balance).map(&:abs).sum
  end

  def income_statement
    # authorize current_user, :user_not_admin?
    @non_zero_accounts = Account.where('balance != ?', 0 )

    @revenue_accounts = @non_zero_accounts.where(category: "Revenue")
    @total_revenues = @revenue_accounts.pluck(:balance).sum

    @expense_accounts = @non_zero_accounts.where(category: "Expense")
    @total_expenses = @expense_accounts.pluck(:balance).sum

    @net_income = @total_revenues.abs - @total_expenses
  end

  def balance_sheet
    # authorize current_user, :user_not_admin?
    @non_zero_accounts = Account.where('balance != ?', 0 )

    @current_assets = @non_zero_accounts.where(category: "Asset").where.not(account_number: [188, 181])
    @equipment_assets = @non_zero_accounts.where(account_number: [188, 181]) # Only Office Equipment and Accumulated Depreciation accounts
    @total_current_assets = @current_assets.pluck(:balance).sum
    @total_equipment_assets = @equipment_assets.pluck(:balance).sum

    @total_assets = @total_current_assets + @total_equipment_assets

    @liability_accounts = @non_zero_accounts.where(name: ["Accounts Payable", "Salaries Payable", "Unearned Revenue"])
    @total_liabilities = @liability_accounts.pluck(:balance).map(&:abs).sum
    @equity_accounts = @non_zero_accounts.where(name: ["Contributed Capital"])

    @retained_earnings_account = ["Retained Earnings", Account.find_by(account_number: 325).balance.abs]
    @total_equity = @equity_accounts.pluck(:balance).map(&:abs).sum + Account.find_by(account_number: 325).balance.abs

    @total_l_and_e = @total_liabilities + @total_equity
  end

  def retained_earnings
    stored_net_income
    @beginning_balance = Account.find_by(account_number: 325).balance.abs
    @net_income #Pulls from stored_net_income
    @less_drawings = Account.where(account_number: [205, 206]).pluck(:balance).sum   #Sums the balance of Common "Dividends Payable" and "Preferred Dividends Payable"
    @ending_balance = (@beginning_balance + @net_income) - @less_drawings
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end

  def error
  end

  private

  def new_gauge(value)
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string'  , 'Name')
    data_table.new_column('number'  , 'Value')
    data_table.add_rows(1)
    data_table.set_cell(0, 0, '' )
    data_table.set_cell(0, 1, value)
    return data_table
  end 

  def get_ratio_options
    opts   = {  :width => 250,      :height => 350, 
                :redFrom => 0,      :redTo => 0.5, 
                :yellowFrom => 0.5,  :yellowTo => 1, 
                :greenFrom => 1,   :greenTo => 10, 
                :min => 0,          :max => 10,
                :minorTicks => 2.5
              }
  end

  def get_percentage_options
    opts   = {  :width => 250,      :height => 350, 
                :redFrom => 0,      :redTo => 7.5, 
                :yellowFrom => 7.5,  :yellowTo => 15, 
                :greenFrom => 15,   :greenTo => 50, 
                :min => 0,          :max => 50,
                :minorTicks => 5
              }
  end

  def calculate_ratio_color(value)
    if value <= 3
      color = "red"
    elsif value >= 3 && value <= 6
      color = "yellow"
    elsif value >= 6
      color = "green"
    end
    return color
  end


  def calculate_percentage_color(value)
    if value <= 7.5
      color = "red"
    elsif value >= 7.5 && value <= 15
      color = "yellow"
    elsif value >= 15
      color = "green"
    end
    return color
  end

  def user_params
    params.permit(:firstName, :lastName, :user_name, :password, :address, :email, :phoneNum, :dob, :userType, :active)    
  end

  def initialize_security_question(user, question_id, answer)
    PasswordAuthorization.create(user_id: user.id, security_question_id: question_id.to_i, answer: answer)
  end

  def stored_net_income
    non_zero_accounts = Account.where('balance != ?', 0 )
    revenue_accounts = Account.find_by(name: "Service Revenue")
    total_revenues = revenue_accounts.balance

    expense_accounts = non_zero_accounts.where(category: "Expense")
    total_expenses = expense_accounts.pluck(:balance).sum

    @net_income = total_revenues.abs - total_expenses
  end
end
