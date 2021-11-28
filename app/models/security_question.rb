class SecurityQuestion < ApplicationRecord
    has_many :password_join_authorizations, dependent: :destroy
    has_many :user, through: :password_join_authorizations
end
