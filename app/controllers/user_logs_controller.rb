class UserLogsController < ApplicationController
  
  def show
    @user_log_id = params[:id][/\d+/].to_i
    if UserEventLog.find(@user_log_id).user_before.empty?
      @before = User.new
      @after = UserEventLog.convert_json_to_model(UserEventLog.find(@user_log_id).user_after)
    elsif UserEventLog.find(@user_log_id).user_after.empty?
      @before = UserEventLog.convert_json_to_model(UserEventLog.find(@user_log_id).user_before)
      @after = UserEventLog.new
    else
      @before = UserEventLog.convert_json_to_model(UserEventLog.find(@user_log_id).user_before)
      @after = UserEventLog.convert_json_to_model(UserEventLog.find(@user_log_id).user_after)
    end
  end
end
  