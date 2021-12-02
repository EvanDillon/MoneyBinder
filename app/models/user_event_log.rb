class UserEventLog < ApplicationRecord
  
  def self.convert_json_to_model(json)
    JSON.parse(json, object_class: User)
  end

  def self.user_log_models()
    # These events still are in json and need to be converted for the view
    @raw_user_logs = UserEventLog.all.reverse()
    @user_logs = []
    @raw_user_logs.each do |user|
      if user.event_type == "Modified"
        before_model = convert_json_to_model(user.user_before)
        after_model = convert_json_to_model(user.user_after)
        @user_logs << [user, before_model, after_model]
      
      elsif user.event_type == "Added"
        before_model = nil
        after_model = convert_json_to_model(user.user_after)
        @user_logs << [user, before_model, after_model]

      elsif user.event_type == "Deactivated"
        before_model = convert_json_to_model(user.user_before)
        after_model = convert_json_to_model(user.user_after)
        @user_logs << [user, before_model, after_model]
      end
    end
    return @user_logs
  end
end
