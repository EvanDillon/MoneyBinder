class User < ApplicationRecord
    validates :username, :email, uniqueness: true
    has_secure_password

    has_many :password_join_authorization, dependent: :destroy
    has_many :security_question, through: :password_join_authorization
    has_many :accounts

    def admin?
      self.userType == 1
    end

    def manager?
      self.userType == 2
    end
    
    def accountant?
      self.userType == 3
    end

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

    # Creates username for new user
  def self.create_username(fname, lname, accountCreated)
    if fname && lname && accountCreated
      user_name = "#{fname.first}#{lname}#{accountCreated.strftime("%m")}#{accountCreated.strftime("%y")}"
      return user_name
    else 
      return nil
    end 
  end
end
