class Account < ApplicationRecord
  validates :name,           uniqueness: true
  validates :account_number, uniqueness: true
  validates :account_number, numericality: { only_integer: true }
  validates :initial_balance, format: {with: /\A\d+(?:\.\d{0,2})?\z/}, numericality: { less_than: 1000000000 }
  has_one :user
  has_many :ledger_entries

  def self.calculate_balance(account)
    account.initial_balance + (account.debit - account.credit)
  end

  def self.update_account_balance(accountId)
    account = Account.find_by(id: accountId)
    ledgers_for_account = LedgerEntry.where(account_id: accountId)
    debit_sum = ledgers_for_account.pluck(:debit).map(&:to_f).reduce(0, :+)
    credit_sum = ledgers_for_account.pluck(:credit).map(&:to_f).reduce(0, :+)
    init_balance = account.initial_balance.to_f

    account.balance = (init_balance + (debit_sum - credit_sum))
    account.save
    return account.balance
  end
end