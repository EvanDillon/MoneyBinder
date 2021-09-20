class ChangeSuspendTillDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :suspendedTill, Time.now
  end
end
