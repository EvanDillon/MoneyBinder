class RemoveNullConstraintFromEventLog < ActiveRecord::Migration[6.1]
  def change
    change_column_null :event_logs, :account_name, true
    change_column_null :event_logs, :user_name, true
    change_column_null :event_logs, :event_type, true
    change_column_null :event_logs, :account_before, true
    change_column_null :event_logs, :account_after, true
    change_column_null :accounts,   :name, true
    change_column_null :accounts,   :account_number, true
  end
end
