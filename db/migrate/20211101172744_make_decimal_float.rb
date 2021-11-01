class MakeDecimalFloat < ActiveRecord::Migration[6.1]
  def change
    change_column :accounts, :initial_balance,  :float, :default => 0.0
    change_column :accounts, :debit,            :float, :default => 0.0
    change_column :accounts, :credit,           :float, :default => 0.0
    change_column :accounts, :balance,          :float, :default => 0.0

    change_column :ledger_entries, :debit,      :float, :default => 0.0
    change_column :ledger_entries, :credit,     :float, :default => 0.0
    change_column :ledger_entries, :balance,    :float, :default => 0.0
  end
end
