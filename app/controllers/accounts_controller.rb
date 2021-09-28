class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.all
    if params[:search_accounts]
      @accounts = Account.search(params[:search_accounts])
      if @accounts.empty?
        flash[:warning] = "No account found"
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

    if @account.save
      redirect_to accounts_path, success: "Account was successfully created."
    else
      flash.now[:danger] = "#{@account.errors.first.full_message}"
      render new_account_path
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    if @account.update(account_params)
      redirect_to accounts_path, success: "Account was successfully updated."
    else
      redirect_to edit_account_path(@account), danger: "#{@account.errors.first.full_message}"
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy
    redirect_to accounts_path, success: "Account was successfully deleted."
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
end
