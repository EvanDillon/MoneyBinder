class CreateJournalEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :journal_entries do |t|
      t.integer :user_id
      t.integer :debit_account,   array: true, default: []
      t.integer :credit_account,  array: true, default: []
      t.decimal :debit_total,     array: true, default: []
      t.decimal :credit_total,    array: true, default: []
      t.text :entry_type
      t.text :status
      t.text :description
      t.date :date_added,         default: Time.now
    end
  end
end
