class ChangeDefaultFloatsFix < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:ledger_entries, :debit, 0)
    change_column_default(:ledger_entries, :credit, 0)
    change_column_default(:ledger_entries, :balance, 0)
  end
end
