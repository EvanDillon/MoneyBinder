# Generate sample users
# require 'bcrypt'

# Creating test users
User.create! do |a|
    a.firstName = 'Admin'
    a.lastName = 'User'
    a.username = 'Admin'
    a.password = "password"
    a.userType = 1
    a.email = 'testAdmin@gmail.com'
    a.phoneNum = '7705555555'
    a.address = '555 Test Street'
    a.active = true
    a.suspendedTill = Time.now
    a.passUpdatedAt = Time.now
end
puts "Created Admin" 

User.create! do |a|
    a.firstName = 'Manager'
    a.lastName = 'User'
    a.username = 'Manager'
    a.password = "password"
    a.userType = 2
    a.email = 'testManager@gmail.com'
    a.phoneNum = '7705555555'
    a.address = '555 Test Street'
    a.active = true
    a.suspendedTill = Time.now
    a.passUpdatedAt = Time.now
end
puts "Created Manager" 

User.create! do |a|
    a.firstName = 'Accountant'
    a.lastName = 'User'
    a.username = 'Accountant'
    a.password = "password"
    a.userType = 3
    a.email = 'testAccountant@gmail.com'
    a.phoneNum = '7705555555'
    a.address = '555 Test Street'
    a.active = true
    a.suspendedTill = Time.now
    a.passUpdatedAt = Time.now
end
puts "Created Accountant" 

User.create! do |a|
    a.firstName = 'Evan'
    a.lastName = 'Dillon'
    a.username = 'EvanD'
    a.password = "password#1"
    a.userType = 3
    a.dob = '3/13/1999'
    a.email = 'evanjdillon@gmail.com'
    a.phoneNum = '7704444444'
    a.address = '317 Apple Street'
    a.active = true
    a.suspendedTill = Time.now
end
puts "Created Evan Dillon" 

User.create! do |a|
    a.firstName = 'James'
    a.lastName = 'Diaz'
    a.username = 'jdiaz35'
    a.password = "password#1"
    a.userType = 3
    a.dob = '4/06/1997'
    a.email = 'Cuizonix@gmail.com'
    a.phoneNum = '5555555555'
    a.address = '123 Sesame Street'
    a.active = true
    a.passUpdatedAt = Time.now-28.days
end
puts "Created James Diaz" 

User.create! do |a|
    a.firstName = 'Expired'
    a.lastName = 'User'
    a.username = 'ExpiredUser'
    a.password = "password"
    a.userType = 2
    a.dob = '10/01/2021'
    a.email = 'testExpired@gmail.com'
    a.phoneNum = '5555555555'
    a.address = '123 Some Street'
    a.active = true
    a.passUpdatedAt = Time.now - 60.days
end
puts "Created Expired User" 

# Creating new security questions
all_questions = ['In what city were you born?', 'What is the name of your first pet?', 'What is your mothers maiden name?']
all_questions.each do |question|
    SecurityQuestion.create! do |a|
        a.question = question
    end
end
puts "Created #{SecurityQuestion.all.count} security questions"

PasswordAuthorization.create(user_id: User.where(username: 'Admin').pluck(:id).first,       security_question_id: 1, answer: 'Atlanta')
PasswordAuthorization.create(user_id: User.where(username: 'Manager').pluck(:id).first, security_question_id: 1, answer: 'Austin')
PasswordAuthorization.create(user_id: User.where(username: 'Accountant').pluck(:id).first, security_question_id: 1, answer: 'DC')
PasswordAuthorization.create(user_id: User.where(username: 'EvanD').pluck(:id).first,       security_question_id: 2, answer: 'Buddy')
PasswordAuthorization.create(user_id: User.where(username: 'jdiaz35').pluck(:id).first,     security_question_id: 1, answer: 'New York')
PasswordAuthorization.create(user_id: User.where(username: 'ExpiredUser').pluck(:id).first, security_question_id: 1, answer: 'LA')

puts "Created #{PasswordAuthorization.all.count} security question relationships"


# Create new accounts
Account.create! do |a|
    a.user_id = 1
    a.name = 'Cash'
    a.account_number = '101'
    a.description = "This account is for Cash"
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Cash'
    a.initial_balance = 1000
    a.debit = 0
    a.credit = 0
    a.balance = 1000
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.active = true
end
puts "Created Cash Account"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Accounts Receivable'
    a.account_number = '122'
    a.description = "This account is for Accounts Receivable"
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Accounts Receivable'
    a.initial_balance = 100.01
    a.debit = 0
    a.credit = 0
    a.balance = 100.01
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.active = true
end
puts "Created Accounts Receivable Account" 

Account.create! do |a|
    a.user_id = 1
    a.name = 'Accounts Payable'
    a.account_number = '202'
    a.description = "This account is for Accounts Payable"
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Accounts Payable'
    a.initial_balance = 1500000.55
    a.debit = 0
    a.credit = 0
    a.balance = 1500000.55
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.active = true
end
puts "Created Accounts Payable Account"

Account.create! do |a|
    a.user_id = 2
    a.name = 'Account with Debit'
    a.account_number = '999'
    a.description = "This account has more money than just the inital balance"
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Example'
    a.initial_balance = 0
    a.debit = 5000
    a.credit = 0
    a.balance = 5000
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.active = true
end
puts "Created High Debit Account" 



all_error_messages = [
                        ["account_updated", "Account has been Updated"],
                        ["account_deleted", "Account has been Deleted"],
                        ["account_created", "Account has been Created"],

                        ["account_not_found", "No account found"],

                        ["user_updated", "User has been Updated"],
                        ["user_deleted", "User has been Deleted"],
                        ["user_created", "User has been Created"],
                        ["user_reset_password", "A link has been sent to your email to reset your password"],
                        ["user_create_request", "A request for your account has been sent to an Administrator to approve"],

                        ["user_expired_password", "Your password is expired. Please reset your password now."],
                        ["user_almost_expired_password_part1", "Your password is going to expire in "],
                        ["user_almost_expired_password_part2", " days. You can change your password in Profile Settings"],

                        ["user_not_found", "Username not found"],

                        ["user_used_password", "Please choose a password you have not used before"],
                        ["user_incorrect_password_part1", "Incorrect Password (Attempts left: "],
                        ["user_incorrect_password_part2", ")"],
                        ["user_suspended", "This account has been suspended for 1 min"],
                        ["user_suspended_until", "This account is suspended until: "],
                        ["user_inactive", "This account is not active"],
                        ["email_sent", "Email was successfully sent."],
                        ["can_not_deactivate_account", "You can not deactivate an account with a balance greater than 0"]
                    ]

# Creates all error messages
all_error_messages.each do |error|
    ErrorMessage.create! do |b|
        b.error_name = error.first
        b.body = error.last
    end
end
puts "Created #{ErrorMessage.count} error messages"


EventLog.create! do |a|
    a.account_name = "Cash"
    a.user_name = "Admin"
    a.event_type = 'Modified'
    a.account_before = "{\"id\":1,\"user_id\":1,\"name\":\"Cash\",\"account_number\":101,\"description\":\"This account is for Cash\",\"normal_side\":\"Debit\",\"category\":\"Asset\",\"subcategory\":\"Cash\",\"initial_balance\":1,\"debit\":0,\"credit\":0,\"balance\":1,\"order\":\"0\",\"statement\":\"0\",\"comment\":\"0\",\"active\":true,\"created_at\":\"2021-10-02T15:32:01.116Z\",\"updated_at\":\"2021-10-02T15:32:01.116Z\"}"
    a.account_after = "{\"id\":1,\"user_id\":1,\"name\":\"Cash\",\"account_number\":101,\"description\":\"This account is for Cash\",\"normal_side\":\"Credit\",\"category\":\"Asset\",\"subcategory\":\"Cash\",\"initial_balance\":123000,\"debit\":0,\"credit\":0,\"balance\":123000,\"order\":\"0\",\"statement\":\"0\",\"comment\":\"0\",\"active\":true,\"created_at\":\"2021-10-02T15:32:01.116Z\",\"updated_at\":\"2021-10-02T15:32:01.116Z\"}"
    a.created_at = Time.now
    a.updated_at = Time.now
end


EventLog.create! do |a|
    a.account_name = "Accounts Receivable"
    a.user_name = "Manager"
    a.event_type = 'Deactivated'
    a.account_before = "{\"id\":2,\"user_id\":1,\"name\":\"Accounts Receivable\",\"account_number\":122,\"description\":\"This account is for Accounts Receivable\",\"normal_side\":\"Debit\",\"category\":\"Asset\",\"subcategory\":\"Accounts Receivable\",\"initial_balance\":7500,\"debit\":0,\"credit\":0,\"balance\":7500,\"order\":\"0\",\"statement\":\"0\",\"comment\":\"0\",\"active\":true,\"created_at\":\"2021-10-02T16:49:44.983Z\",\"updated_at\":\"2021-10-02T16:49:44.983Z\"}"
    a.account_after = "{\"id\":2,\"user_id\":1,\"name\":\"Accounts Receivable\",\"account_number\":122,\"description\":\"This account is for Accounts Receivable\",\"normal_side\":\"Debit\",\"category\":\"Asset\",\"subcategory\":\"Accounts Receivable\",\"initial_balance\":7500,\"debit\":0,\"credit\":0,\"balance\":7500,\"order\":\"0\",\"statement\":\"0\",\"comment\":\"0\",\"active\":false,\"created_at\":\"2021-10-02T16:49:44.983Z\",\"updated_at\":\"2021-10-02T16:49:44.983Z\"}"
    a.created_at = Time.now
    a.updated_at = Time.now
end

EventLog.create! do |a|
    a.account_name = "Accounts Payable"
    a.user_name = "EvanD"
    a.event_type = 'Added'
    a.account_before = ""
    a.account_after = "{\"id\":3,\"user_id\":2,\"name\":\"Accounts Payable\",\"account_number\":202,\"description\":\"This account is for Accounts Payable\",\"normal_side\":\"Credit\",\"category\":\"Liability\",\"subcategory\":\"Accounts Payable\",\"initial_balance\":0,\"debit\":0,\"credit\":0,\"balance\":0,\"order\":\"0\",\"statement\":\"0\",\"comment\":\"0\",\"active\":true,\"created_at\":\"2021-10-02T15:32:01.116Z\",\"updated_at\":\"2021-10-02T15:32:01.116Z\"}"
    a.created_at = Time.now
    a.updated_at = Time.now
end
puts "Created #{EventLog.count} EventLogs"
