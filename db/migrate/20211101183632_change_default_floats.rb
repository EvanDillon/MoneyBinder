class ChangeDefaultFloats < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:ledger_entries, :debit, nil)
    change_column_default(:ledger_entries, :credit, nil)
    change_column_default(:ledger_entries, :balance, nil)
  end
end