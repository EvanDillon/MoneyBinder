class PasswordJoinAuthorization < ApplicationRecord
    belongs_to :security_question, optional: true
    belongs_to :user
end
