class Account < ApplicationRecord
  validates :name,           uniqueness: true
  validates :account_number, uniqueness: true
  validates :account_number, :initial_balance, :debit, :credit, :balance, numericality: { only_integer: true }
  has_one :user

  def self.search(search)
    if search.nil? || search.empty?
      Account.all
    else
      found_name_match = Account.where(name: search)
      found_number_match = Account.where(account_number: search)
      if found_name_match.empty? && found_number_match.empty?
        []
      else
        found_name_match | found_number_match
      end    
    end
  end
end