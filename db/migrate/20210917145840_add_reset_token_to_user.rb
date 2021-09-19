class AddResetTokenToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.string :reset
    end
  end
end
