class CreateLedgerEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :ledger_entries do |t|
      t.belongs_to :account
      t.integer :postReference        
      t.decimal :debit,         default: nil
      t.decimal :credit,        default: nil
      t.decimal :balance
      t.text :description
      t.timestamps
    end
  end
end
