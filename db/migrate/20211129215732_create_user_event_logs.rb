class CreateUserEventLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :user_event_logs do |t|

      t.text :user_name,     null: false
      t.text :event_type,    null: false
      t.text :user_before,   null: false
      t.text :user_after,    null: false

      t.timestamps
    end
  end
end
