class AccountTableChangeInttoDec < ActiveRecord::Migration[6.1]
  def change
    change_column :accounts, :initial_balance,  :decimal 
    change_column :accounts, :balance,          :decimal 
    change_column :accounts, :debit,            :decimal 
    change_column :accounts, :credit,           :decimal 
  end
end
