class EventLogsController < ApplicationController
  before_action :set_event_log, only: %i[ show edit update destroy ]

  # GET /event_logs or /event_logs.json
  def index
    # These events still are in json and need to be converted for the view
    @raw_event_logs = EventLog.all.reverse()
    @event_logs = []
    @raw_event_logs.each do |event|
      if event.event_type == "Modified"
        before_model = convert_json_to_model(event.account_before)
        after_model = convert_json_to_model(event.account_after)
        @event_logs << [event, before_model, after_model]

      elsif event.event_type == "Added"
        before_model = nil
        after_model = convert_json_to_model(event.account_after)
        @event_logs << [event, before_model, after_model]

      elsif event.event_type == "Deactivated"
        before_model = convert_json_to_model(event.account_before)
        after_model = convert_json_to_model(event.account_after)
        @event_logs << [event, before_model, after_model]
      end
    end
    @approved_journal_entries = JournalEntry.where(status: "Approved")
    @user_logs = UserEventLog.user_log_models()
  end

  # GET /event_logs/1 or /event_logs/1.json
  def show
    @event_id = params[:id][/\d+/]
    if EventLog.find(@event_id).account_before.empty?
      @before = Account.new
      @after = convert_json_to_model(EventLog.find(@event_id).account_after)

    elsif EventLog.find(@event_id).account_after.empty?
      @before = convert_json_to_model(EventLog.find(@event_id).account_before)
      @after = Account.new
    else
      @before = convert_json_to_model(EventLog.find(@event_id).account_before)
      @after = convert_json_to_model(EventLog.find(@event_id).account_after)
    end
  end

  # GET /event_logs/new
  def new
    @event_log = EventLog.new
  end

  # GET /event_logs/1/edit
  def edit
  end

  # POST /event_logs or /event_logs.json
  def create
    @event_log = EventLog.new(event_log_params)
  end

  # PATCH/PUT /event_logs/1 or /event_logs/1.json
  def update
    respond_to do |format|
      if @event_log.update(event_log_params)
        format.html { redirect_to @event_log, notice: "Event log was successfully updated." }
        format.json { render :show, status: :ok, location: @event_log }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_log.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_logs/1 or /event_logs/1.json
  def destroy
    @event_log.destroy
    respond_to do |format|
      format.html { redirect_to event_logs_url, notice: "Event log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_log
      @event_log = EventLog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_log_params
      params.fetch(:event_log, {})
    end

    def convert_json_to_model(json)
      JSON.parse(json, object_class: Account)
    end
end
