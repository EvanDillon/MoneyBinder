class JournalEntriesController < ApplicationController
  before_action :set_journal_entry, only: %i[ show edit update destroy ]

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

    date = DateTime.new(journal_entry_params["date_added(1i)"].to_i, journal_entry_params["date_added(2i)"].to_i, journal_entry_params["date_added(3i)"].to_i)

    @journal_entry = JournalEntry.new(  user_id: current_user.id,
                                        debit_account: debit_account_ids,
                                        credit_account: credit_account_ids,
                                        debit_total: debit_amounts,
                                        credit_total: credit_amounts,
                                        entry_type: journal_entry_params[:entry_type],  
                                        status: "Pending",
                                        description: journal_entry_params[:description],
                                        date_added: date
                                      )
    if @journal_entry.save
      redirect_to journal_entries_path, success: "Created Entry"
    else
      flash.now[:danger] = "#{@account.errors.first.full_message}"
      render new_journal_entry_path
    end
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
end
