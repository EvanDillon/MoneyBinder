class SecurityQuestion < ApplicationRecord
    has_many :password_authorization, dependent: :destroy
    has_many :user, through: :password_authorization
end
