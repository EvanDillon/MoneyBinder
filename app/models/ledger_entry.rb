class LedgerEntry < ApplicationRecord

  def self.create_new_entry(entry)
    (0..entry.debit_account.count-1).each do |index|
      accountId = entry.debit_account[index]
      ledger_debit = entry.debit_total[index].to_f
      post_ref = entry.id
      desc = entry.description
      
      new_ledger_entry = LedgerEntry.create( 
                          account_id: accountId, 
                          postReference: post_ref, 
                          debit: ledger_debit, 
                          description: desc
                        )
      new_balance = Account.update_account_balance(accountId)
      new_ledger_entry.balance = new_balance
      new_ledger_entry.save    
    end 

    (0..entry.credit_account.count-1).each do |index|
      accountId = entry.credit_account[index]
      ledger_credit = entry.credit_total[index].to_f
      post_ref = entry.id
      desc = entry.description

      new_ledger_entry = LedgerEntry.create( 
                          account_id: accountId, 
                          postReference: post_ref, 
                          credit: ledger_credit, 
                          description: desc
                        )
      new_balance = Account.update_account_balance(accountId)
      new_ledger_entry.balance = new_balance
      new_ledger_entry.save
    end 
  end
end