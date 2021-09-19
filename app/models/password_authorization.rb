class PasswordAuthorization < ApplicationRecord
    belongs_to :security_question
    belongs_to :user
end
