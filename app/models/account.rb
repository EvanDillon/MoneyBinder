class Account < ApplicationRecord
  validates :name,           uniqueness: true
  validates :account_number, uniqueness: true
  validates :account_number, numericality: { only_integer: true }
  validates :initial_balance, format: {with: /\A\d+(?:\.\d{0,2})?\z/}, numericality: { less_than: 1000000000 }
  # , :initial_balance, :debit, :credit, :balance,
  has_one :user

  def self.calculate_balance(account)
    account.initial_balance + (account.debit - account.credit)
  end
end