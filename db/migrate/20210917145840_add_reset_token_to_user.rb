class AddResetTokenToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.text :reset
    end
  end
end
