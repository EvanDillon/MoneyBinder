class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:login, :welcome, :sign_up, :process_new_sign_up]
  before_action :stored_net_income, :only => [:income_statement, :retained_earnings]
  before_action :trial_balance,     :only => [:homepage, :send_trial_balance]
  before_action :income_statement,  :only => [:homepage, :send_income_statement]
  before_action :retained_earnings, :only => [:homepage, :send_retained_earnings]
  before_action :balance_sheet,     :only => [:homepage, :send_balance_sheet]
  
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
    if !@total_liabilities.zero?
      current_ratio = ActionController::Base.helpers.number_with_precision((@total_current_assets / @total_liabilities), precision: 2, delimiter: ',').to_f
    else
      current_ratio = 0.0
    end

    # Asset Turnover ratio  (Net income / total assets)
    if !@net_income.zero? || !@total_assets.zero?
      asset_turnover_ratio = ActionController::Base.helpers.number_with_precision((@net_income / (@total_assets / 2)), precision: 2, delimiter: ',').to_f
    else
      asset_turnover_ratio = 0
    end

    @total_inventory = @non_zero_accounts.where(account_number: [130, 139]).pluck(:balance).sum
    if !@total_liabilities.zero?
      quick_ratio = ActionController::Base.helpers.number_with_precision(((@total_current_assets - @total_inventory) / @total_liabilities ), precision: 2, delimiter: ',').to_f
    else
      quick_ratio = 0.0
    end

    # Return on Equity Ratio (ROE)  (Net income / Shareholder equity)
    if !@total_equity.zero?
      reo_percentage = ActionController::Base.helpers.number_with_precision((@net_income / @total_equity)*100, precision: 1, delimiter: ',').to_f
    else
      reo_percentage = 0.0
    end

    # Return on asset
    if !@total_assets.zero?
      return_on_asset = ActionController::Base.helpers.number_with_precision((@net_income / @total_assets)*100, precision: 1, delimiter: ',').to_f
    else
      return_on_asset = 0.0
    end

    # Net Profit ratio
    net_profit_helper = Account.find_by(name: 'Service Revenue').balance
    if !net_profit_helper.zero?
      net_profit = ActionController::Base.helpers.number_with_precision((@net_income / (net_profit_helper.abs))*100, precision: 1, delimiter: ',').to_f
    else
      net_profit = 0.0
    end
    
    # Asset Turnover Ratio  (sales / total assets)
    if !@total_assets.zero?
      asset_turnover_ratio = ActionController::Base.helpers.number_with_precision(((net_profit_helper.abs) / @total_assets), precision: 2, delimiter: ',').to_f
    else
      asset_turnover_ratio = 0.0
    end

    # Ratios                                                                                              (red_max, yellow_max, max_limit, ticks)
    current_ratio_gauge =         GoogleVisualr::Interactive::Gauge.new(  new_gauge(current_ratio),        get_options(0.5, 1, 10, 2.5))
    quick_ratio_gauge =           GoogleVisualr::Interactive::Gauge.new(  new_gauge(quick_ratio),          get_options(0.5, 1, 10, 2.5))
    asset_turnover_ratio_gauge =  GoogleVisualr::Interactive::Gauge.new(  new_gauge(asset_turnover_ratio), get_options(0.5, 1, 2, 2.5))

    # Percentages 
    reo_percentage_gauge =        GoogleVisualr::Interactive::Gauge.new(  new_gauge(reo_percentage),       get_options(7.5, 15, 50, 5))
    return_on_asset_gauge =       GoogleVisualr::Interactive::Gauge.new(  new_gauge(return_on_asset),      get_options(7.5, 15, 50, 5))
    net_profit_gauge =            GoogleVisualr::Interactive::Gauge.new(  new_gauge(net_profit),           get_options(7.5, 15, 50, 5))

    #                             Gauge:                        Value:                Color:  (value, red_max, yellow_max)       Name:
    current_ratio_data =          [current_ratio_gauge,         current_ratio,        calc_color(current_ratio, 0.5, 1),        "Current Ratio"]
    quick_ratio_data =            [quick_ratio_gauge,           quick_ratio,          calc_color(quick_ratio, 0.5, 1),          "Quick Ratio"]
    asset_turnover_ratio_data =   [asset_turnover_ratio_gauge,  asset_turnover_ratio, calc_color(asset_turnover_ratio, 0.5, 1), "Asset Turnover"]
    reo_percentage_data =         [reo_percentage_gauge,        reo_percentage,       calc_color(reo_percentage, 7.5, 15),      "Return on Equity"]
    return_on_asset_data =        [return_on_asset_gauge,       return_on_asset,      calc_color(return_on_asset, 7.5, 15),     "Return on Asset"]
    net_profit_data =             [net_profit_gauge,            net_profit,           calc_color(net_profit, 7.5, 15),          "Net Profit Ratio"]

    # Once you create a new gauge at to this array 
    @ratio_gauges = [current_ratio_data, quick_ratio_data, asset_turnover_ratio_data]
    @percentage_gauges = [reo_percentage_data, return_on_asset_data, net_profit_data]
    @index = @ratio_gauges.count
  end

  def sign_up
    @user = User.new
  end

  def process_new_sign_up
    @user = User.new(user_params)
    user_name = User.create_username(params[:firstName], params[:lastName], Time.zone.now)
    pass_check = User.valid_pass?(params[:password])
    password_update = Time.now

    if pass_check.empty? && !user_name.nil?
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
        flash.now[:danger] = "#{@user.errors.full_messages.first}"
        render "sessions/sign_up"
      end
    else
      flash.now[:danger] = "#{pass_check}"
      render "sessions/sign_up"
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
    @non_zero_accounts = Account.where('balance != ?', 0).order(:account_number)
    @debit_total = @non_zero_accounts.where(normal_side: "Debit").pluck(:balance).map(&:abs).sum
    @credit_total = @non_zero_accounts.where(normal_side: "Credit").pluck(:balance).map(&:abs).sum

    # Creates the trial_balance PDF
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "trial_balance_#{Time.now.year}", 
                template: "sessions/reports_pdf/trial_balance_pdf.html.erb"
      end
    end
  end

  def income_statement
    # authorize current_user, :user_not_admin?
    @non_zero_accounts = Account.where('balance != ?', 0 )

    @revenue_accounts = @non_zero_accounts.where(category: "Revenue")
    @total_revenues = @revenue_accounts.pluck(:balance).sum

    @expense_accounts = @non_zero_accounts.where(category: "Expense")
    @total_expenses = @expense_accounts.pluck(:balance).sum

    @net_income = @total_revenues.abs - @total_expenses

    # Creates the income_statement PDF
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "income_statement_#{Time.now.year}", 
                template: "sessions/reports_pdf/income_statement_pdf.html.erb"
      end
    end
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

    @retained_earnings_account = ["Retained Earnings", Account.retained_earnings_value()]
    @total_equity = @equity_accounts.pluck(:balance).map(&:abs).sum + Account.retained_earnings_value()

    @total_l_and_e = @total_liabilities + @total_equity

    # Creates the balance_sheet PDF
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "balance_sheet_#{Time.now.year}", 
                template: "sessions/reports_pdf/balance_sheet_pdf.html.erb"
      end
    end
  end

  def retained_earnings
    stored_net_income
    @beginning_balance = Account.find_by(account_number: 325).balance.abs
    @net_income #Pulls from stored_net_income
    @total_earnings = @beginning_balance + @net_income
    @less_drawings = Account.where(account_number: [205, 206]).pluck(:balance).sum   #Sums the balance of Common "Dividends Payable" and "Preferred Dividends Payable"
    @ending_balance = (@total_earnings) - @less_drawings

    # Creates the retained_earnings PDF
    respond_to do |format|
      format.html
      format.pdf do
        render  pdf: "retained_earnings_#{Time.now.year}", 
                template: "sessions/reports_pdf/retained_earnings_pdf.html.erb"
      end
    end
  end

  def send_trial_balance
    recipient_user = User.find_by(email: params[:email])
    PdfMailer.with( pdf_name: params[:pdf], 
                    user_email: params[:email], 
                    sender_user: current_user, 
                    non_zero_accounts: @non_zero_accounts
                  ).trial_balance_email.deliver_now
    redirect_to trial_balance_path, success: "Report has been successfully emailed to: '#{recipient_user.username}'"
  end

  def send_income_statement
    recipient_user = User.find_by(email: params[:email])
    PdfMailer.with( pdf_name: params[:pdf], 
                    user_email: params[:email], 
                    sender_user: current_user, 
                    revenue_accounts: @revenue_accounts,
                    total_revenues: @total_revenues,
                    expense_accounts: @expense_accounts,
                    total_expenses: @total_expenses
                  ).income_statement_email.deliver_now
    redirect_to income_statement_path, success: "Report has been successfully emailed to: '#{recipient_user.username}'"
  end

  def send_retained_earnings
    recipient_user = User.find_by(email: params[:email])
    PdfMailer.with( pdf_name: params[:pdf], 
                    user_email: params[:email], 
                    sender_user: current_user, 
                    beginning_balance: @beginning_balance,
                    net_income: @net_income,
                    less_drawings: @less_drawings
                  ).retained_earnings_email.deliver_now
    redirect_to retained_earnings_path, success: "Report has been successfully emailed to: '#{recipient_user.username}'"
  end

  def send_balance_sheet
    recipient_user = User.find_by(email: params[:email])
    PdfMailer.with( pdf_name: params[:pdf], 
                    user_email: params[:email], 
                    sender_user: current_user, 
                    current_assets: @current_assets,
                    equipment_assets: @equipment_assets,
                    liability_accounts: @liability_accounts,
                    equity_accounts: @equity_accounts,
                    retained_earnings_account: @retained_earnings_account,
                    total_equity: @total_equity
                  ).balance_sheet_email.deliver_now
    redirect_to balance_sheet_path, success: "Report has been successfully emailed to: '#{recipient_user.username}'"
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

  def get_options(red_max, yellow_max, max_limit, ticks)
    opts =  { 
              :width => 250,            :height => 350, 
              :redFrom => 0,            :redTo => red_max, 
              :yellowFrom => red_max,   :yellowTo => yellow_max, 
              :greenFrom => yellow_max, :greenTo => max_limit, 
              :min => 0,                :max => max_limit,
              :minorTicks => ticks
            }
  end

  def calc_color(value, red_max, yellow_max)
    if value <= red_max
      color = "red"
    elsif value >= red_max && value <= yellow_max
      color = "yellow"
    elsif value >= yellow_max
      color = "green"
    end
  end

  def user_params
    params.permit(:firstName, :lastName, :user_name, :password, :address, :email, :phoneNum, :dob, :userType, :active)    
  end

  def initialize_security_question(user, question_id, answer)
    PasswordJoinAuthorization.create(user_id: user.id, security_questions_id: question_id.to_i, answer: answer)
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
