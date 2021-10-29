class JournalEntriesController < ApplicationController
  before_action :set_journal_entry, only: %i[ show edit update destroy invalid_num_error ]
  rescue_from ActionView::Helpers::NumberHelper::InvalidNumberError, :with => :invalid_num_error


  # GET /journal_entries or /journal_entries.json
  def index
    @journal_entries = JournalEntry.all
  end

  # GET /journal_entries/new
  def new
    @journal_entry = JournalEntry.new
  end

  # POST /journal_entries or /journal_entries.json
  def create
    debit_account_ids = journal_entry_params[:debit_account].map(&:to_i)
    credit_account_ids = journal_entry_params[:credit_account].map(&:to_i)

    debit_amounts = journal_entry_params[:debit_total]
    credit_amounts = journal_entry_params[:credit_total]

    @journal_entry = JournalEntry.new(  user_id: current_user.id,
                                        debit_account: debit_account_ids,
                                        credit_account: credit_account_ids,
                                        debit_total: debit_amounts,
                                        credit_total: credit_amounts,
                                        entry_type: journal_entry_params[:entry_type],  
                                        status: "Pending",
                                        description: params[:journal_entry][:description]
                                      )

    error_list = valid?(debit_account_ids, credit_account_ids, debit_amounts, credit_amounts)
    error_list = balanced?(debit_amounts, credit_amounts) if !balanced?(debit_amounts, credit_amounts).nil?

    if error_list.nil?
      date = DateTime.new(journal_entry_params["date(1i)"].to_i, journal_entry_params["date(2i)"].to_i, journal_entry_params["date(3i)"].to_i)
      @journal_entry.date_added = date
      
      if @journal_entry.save
        redirect_to journal_entries_path, success: "Journal Entry Pending"
        User.where(userType: 2).pluck(:email).each do |email|
          ResetMailer.with(user_email: email).pending_journal_entry.deliver_now
        end
      else
        flash.now[:danger] = "#{@account.errors.first.full_message}"
        render new_journal_entry_path
      end
    else
      @journal_entry.debit_total = [debit_amounts.first]
      @journal_entry.credit_total = [credit_amounts.first]

      flash.now[:danger] = "#{error_list}"
      render new_journal_entry_path
    end
  end

  def approve
    @entry = JournalEntry.find(params[:entry].to_i)
    @entry.status = "Approved"
    @entry.save

    LedgerEntry.create_new_entry(@entry)
    redirect_to journal_entries_path, success: "Journal entry approved"
  end

  def decline
    @entry = JournalEntry.find(params[:entry].to_i)
    @entry.status = "Declined"
    @entry.description = params[:reason]
    @entry.save
    redirect_to journal_entries_path, danger: "Journal entry declined"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal_entry
      @journal_entry = JournalEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def journal_entry_params
      params.fetch(:journal_entry, {})
    end

    def valid?(debit_accounts, credit_accounts, debit, credit)
      # Checks if debit accounts are all dif
      if debit_accounts.uniq.length == debit_accounts.length
        # Checks if credit accounts are all dif
        if credit_accounts.uniq.length == credit_accounts.length
          # Checks if debit and credit accounts have same account
          if (debit_accounts - credit_accounts).count == debit_accounts.count

            # Check if debit has only 2 decimals and is not negative
            debit.each do |num|
              if num.to_f > 0
                ActionController::Base.helpers.number_to_currency(num, precision: 2, raise: true)
              else
                return "Debit amount can not be 0"
              end
            end

            # Check if credit has only 2 decimals and converts it to currency
            credit.each do |num|
              if num.to_f > 0
                ActionController::Base.helpers.number_to_currency(num, precision: 2, raise: true)
              else
                return "Credit amount can not be 0"
              end
            end

            return nil
          else
            return "You can not debit and credit from the same account"
          end
        else
          return "You can not credit from the same account twice"
        end
      else
        return "You can not debit from the same account twice"
      end
    end

    def balanced?(debit, credit)
      debit_sum = 0
      debit.each do |num|
        debit_sum += ActionController::Base.helpers.number_with_precision(num, precision: 2).to_f
      end  

      credit_sum = 0
      credit.each do |num|
        credit_sum += ActionController::Base.helpers.number_with_precision(num, precision: 2).to_f
      end 

      if debit_sum == credit_sum
        return nil
      else
        return "Total Debits and Credits are not balanced: (Debit = $#{debit_sum}, Credit = $#{credit_sum})"
      end
    end
    
    def invalid_num_error
      flash.now[:danger] = "Debit/Credit value is not a correct number"
      render new_journal_entry_path
    end
end
