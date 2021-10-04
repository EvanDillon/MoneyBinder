class CreateEventLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :event_logs do |t|
      t.string :account_name,      null: false
      t.string :user_name,         null: false
      t.string :event_type,       null: false
      t.string :account_before,   null: false
      t.string :account_after,    null: false

      t.timestamps
    end
  end
end
