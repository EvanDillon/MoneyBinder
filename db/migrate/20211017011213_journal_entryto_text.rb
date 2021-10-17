class JournalEntrytoText < ActiveRecord::Migration[6.1]
  def change
    change_column :journal_entries, :debit_account, :text
    change_column :journal_entries, :credit_account, :text
    change_column :journal_entries, :debit_total, :text
    change_column :journal_entries, :credit_total, :text
  end
end
