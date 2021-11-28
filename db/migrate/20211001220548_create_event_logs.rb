class CreateEventLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :event_logs do |t|
      t.text :account_name,      null: false
      t.text :user_name,         null: false
      t.text :event_type,       null: false
      t.text :account_before,   null: false
      t.text :account_after,    null: false

      t.timestamps
    end
  end
end
