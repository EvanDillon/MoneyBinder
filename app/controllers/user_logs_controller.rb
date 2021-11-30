class UserLogsController < ApplicationController
    before_action :set_user_log, only: %i[ show edit update destroy ]
  
    # GET /event_logs or /event_logs.json
    def index
      # These events still are in json and need to be converted for the view
      @raw_user_logs = User.all.reverse()
      @user_logs = []
      @raw_user_logs.each do |user|
        if user.userType == "Modified"
          before_model = convert_json_to_model(user.account_before)
          after_model = convert_json_to_model(user.account_after)
          @user_logs << [user, before_model, after_model]
        
        elsif user.userType == "Added"
          before_model = nil
          after_model = convert_json_to_model(user.account_after)
          @user_logs << [user, before_model, after_model]
  
        elsif user.userType == "Deactivated"
          before_model = convert_json_to_model(user.account_before)
          after_model = convert_json_to_model(user.account_after)
          @user_logs << [user, before_model, after_model]
        end
      end
    end
  
    # GET /event_logs/1 or /event_logs/1.json
    def show
      @user_id = params[:id][/\d+/]
      if User.find(@user_id).account_before.empty?
        @before = User.new
        @after = convert_json_to_model(User.find(@user_id).account_after)
      elsif User.find(@user_id).account_after.empty?
        @before = convert_json_to_model(User.find(@user_id).account_before)
        @after = User.new
      else
        @before = convert_json_to_model(User.find(@user_id).account_before)
        @after = convert_json_to_model(User.find(@user_id).account_after)
      end
    end
  
    # GET /event_logs/new
    def new
      @user_event_log = UserEventLog.new
    end
  
    # GET /event_logs/1/edit
    def edit
    end
  
    # POST /event_logs or /event_logs.json
    def create
      @user_log = User.new(user_log_params)
    end
  
    # PATCH/PUT /event_logs/1 or /event_logs/1.json
    def update
    end
  
    # DELETE /event_logs/1 or /event_logs/1.json
    def destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_user_log
        @user_log = User.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def user_log_params
        params.fetch(:user_log, {})
      end
  
      def convert_json_to_model(json)
        JSON.parse(json, object_class: User)
      end
  end
  