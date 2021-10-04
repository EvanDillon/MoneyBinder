json.extract! event_log, :id, :created_at, :updated_at
json.url event_log_url(event_log, format: :json)
