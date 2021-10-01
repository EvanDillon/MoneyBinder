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

PasswordAuthorization.create(user_id: User.where(username: 'Admin').pluck(:id).first, security_question_id: 1, answer: 'Atlanta')
PasswordAuthorization.create(user_id: User.where(username: 'EvanD').pluck(:id).first, security_question_id: 2, answer: 'Buddy')
PasswordAuthorization.create(user_id: User.where(username: 'jdiaz35').pluck(:id).first, security_question_id: 1, answer: 'New York')
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
    a.initial_balance = 123000
    a.debit = 0
    a.credit = 0
    a.balance = 123000
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
    a.initial_balance = 7500
    a.debit = 0
    a.credit = 0
    a.balance = 7500
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.active = true
end
puts "Created Cash Accounts Receivable Account" 

Account.create! do |a|
    a.user_id = 1
    a.name = 'Accounts Payable'
    a.account_number = '202'
    a.description = "This account is for Accounts Payable"
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Accounts Payable'
    a.initial_balance = 1450000
    a.debit = 0
    a.credit = 0
    a.balance = 1450000
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.active = true
end
puts "Created Accounts Payable Account" 



all_error_messages = [
                        ["account_updated", "Account has been Updated"],
                        ["account_deleted", "Account has been Deleted"]
                    ]

# Creates all error messages
all_error_messages.each do |error|
    ErrorMessage.create! do |b|
        b.error_name = error.first
        b.body = error.last
    end
end
puts "Created #{ErrorMessage.count} error messages"