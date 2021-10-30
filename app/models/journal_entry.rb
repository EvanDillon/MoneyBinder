class JournalEntry < ApplicationRecord
    serialize :debit_account, Array
    serialize :credit_account, Array
    serialize :debit_total, Array
    serialize :credit_total, Array

    has_one_attached :source_document
end
