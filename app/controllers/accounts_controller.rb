class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all
    if params[:search_accounts]
      @accounts = Account.search(params[:search_accounts])
      if @accounts.empty?
        flash[:warning] = ErrorMessage.find_by(error_name: "account_not_found").body
      else
        flash.clear
      end
    end
  end

  # GET /accounts/1 or /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create
    @account = Account.new(account_params)
    @account.user_id = current_user.id
    @account.balance = calculate_balance(@account)

    if @account.save
      create_event_log("", @account, "Added")
      redirect_to accounts_path, success: ErrorMessage.find_by(error_name: "account_created").body
    else
      flash.now[:danger] = "#{@account.errors.first.full_message}"
      render new_account_path
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    @account_before = @account.to_json
    if @account.update(account_params)
      @account.balance = calculate_balance(@account)
      @account.save
      @account_after = @account.to_json

      create_event_log(@account_before, @account_after, "Modified")
      redirect_to accounts_path, success: ErrorMessage.find_by(error_name: "account_updated").body
    else
      redirect_to edit_account_path(@account), danger: "#{@account.errors.first.full_message}"
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    create_event_log(@account, "", "Deactivated")
    @account.destroy
    redirect_to accounts_path, success: ErrorMessage.find_by(error_name: "account_deleted").body
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.fetch(:account, {}).permit!
    end

    def calculate_balance(account)
      account.initial_balance + (account.debit - account.credit)
    end

    def create_event_log(before, after, type)
      if type == "Added"
        EventLog.new( account_name: after.name, 
                      user_name: current_user.username, 
                      event_type: type, 
                      account_before: before, 
                      account_after: after.to_json
                    ).save

      elsif type == "Deactivated"
        EventLog.new( account_name: before.name, 
                      user_name: current_user.username, 
                      event_type: type, 
                      account_before: before.to_json, 
                      account_after: after
                    ).save
      
      elsif type == "Modified"
        EventLog.new( account_name: JSON.parse(before, object_class: Account).name, 
                      user_name: current_user.username, 
                      event_type: type, 
                      account_before: before, 
                      account_after: after
                    ).save
      end
    end
end
