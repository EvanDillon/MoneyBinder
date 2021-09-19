class User < ApplicationRecord
    validates :username, :email, uniqueness: true
    has_secure_password

    has_many :password_authorization, dependent: :destroy
    has_many :security_question, through: :password_authorization

    def self.valid_pass?(pass)
        if pass.length >= 8 
          if pass.first.match?(/[[:alpha:]]/)
            if pass.match?(/[[:alpha:]]/) && pass.match?(/[[:digit:]]/) && pass.index( /[^[:alnum:]]/ ) != nil
              return ""
            else
              return "Password must have a letter, a number, and a special character. \n"
            end
          else 
            return "Password must start with a letter. \n"
          end
        else
          return "Password needs to be at least 8 characters. \n"
        end   
    end
end
