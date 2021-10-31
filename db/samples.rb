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

    a.firstName = 'Katy'
    a.lastName = 'Highers'
    a.username = 'khighers1021'
    a.password = "password1!"
    a.userType = 2
    a.dob = '2/19/2000'
    a.email = 'kathrynhighers@gmail.com'
    a.phoneNum = '5555555555'
    a.address = '123 Sesame Street'
    a.active = true
    a.passUpdatedAt = Time.now-28.days
end
puts "Created Katy Highers"

User.create! do|a|
    a.firstName = 'Andrew'
    a.lastName = 'Shein'
    a.username = 'ashein1021'
    a.password = "password"
    a.userType = 3
    a.dob = '8/04/1997'
    a.email = 'ashein60@gmail.com'
    a.phoneNum = '7777777777'
    a.address = '645 Fire Street'
    a.active = true
    a.passUpdatedAt = Time.now
end
puts "Created Andrew Shein" 

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


# The following accounts are from the Chart of Accounts document.
# Accounts that used the same number multiple times in the document are collapsed into one account with a description
# acknowledging everything that it contains.

# 100s - Cash Related Accounts

Account.create! do |a|
    a.user_id = 1
    a.name = 'Cash'
    a.account_number = '101'
    a.description = "The cash account."
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Short Term'
    a.initial_balance = 0 # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Petty Cash'
    a.account_number = '105'
    a.description = "Discretionary funds for when it is not sensible to make any disbursement by check."
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Short Term'
    a.initial_balance = 7000
    a.debit = 0
    a.credit = 0
    a.balance = 7000
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 120s Receivables

Account.create! do |a|
    a.user_id = 1
    a.name = 'Notes Receivable'
    a.account_number = '121'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Current'
    a.initial_balance = 99000
    a.debit = 0
    a.credit = 0
    a.balance = 99000
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Accounts Receivable'
    a.account_number = '122'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Current'
    a.initial_balance = 0  # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"


Account.create! do |a|
    a.user_id = 1
    a.name = 'Interest Receivable'
    a.account_number = '123'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Current'
    a.initial_balance = 1500.89
    a.debit = 0
    a.credit = 0
    a.balance = 1500.89
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Common Stock Subscriptions Receivable'
    a.account_number = '125'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Current'
    a.initial_balance = 560.50
    a.debit = 0
    a.credit = 0
    a.balance = 560.50
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = true
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Preferred Stock Subscriptions Receivable'
    a.account_number = '126'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Current'
    a.initial_balance = 85783
    a.debit = 0
    a.credit = 0
    a.balance = 85783
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# Inventories

Account.create! do |a|
    a.user_id = 1
    a.name = 'Merchandise Inventory'
    a.account_number = '131'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 100000
    a.debit = 0
    a.credit = 0
    a.balance = 100000
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Raw Materials'
    a.account_number = '132'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 300000
    a.debit = 0
    a.credit = 0
    a.balance = 300000
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Work in Process'
    a.account_number = '133'
    a.description = "Partially completed goods."
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 4000000
    a.debit = 0
    a.credit = 0
    a.balance = 400000
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Finish Goods'
    a.account_number = '134'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 140s - Prepaid Items

Account.create! do |a|
    a.user_id = 1
    a.name = 'Supplies'
    a.account_number = '141'
    a.description = "Specialty items like Medical, Bicycle, Tailoring, etc."
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0 #  # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Office Supplies'
    a.account_number = '142'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Food Supplies'
    a.account_number = '144'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Prepaid Insurance'
    a.account_number = '145'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Current'
    a.initial_balance = 0 # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# In solved problem, but not Chart of Accounts
Account.create! do |a|
    a.user_id = 1
    a.name = 'Prepaid Rent'
    a.account_number = '146'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Current'
    a.initial_balance = 0 # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 150s - Long-Term Investments

Account.create! do |a|
    a.user_id = 1
    a.name = 'Bond Sinking Fund'
    a.account_number = '153'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 160s Land

Account.create! do |a|
    a.user_id = 1
    a.name = 'Land'
    a.account_number = '161'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Natural Resources'
    a.account_number = '162'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 170s - Buildings

Account.create! do |a|
    a.user_id = 1
    a.name = 'Buildings'
    a.account_number = '171'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 180s - Equipment

Account.create! do |a|
    a.user_id = 1
    a.name = 'Office Equipment'
    a.account_number = '181'
    a.description = "Also Store Equipment"
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0 #  # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Office Furniture'
    a.account_number = '182'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Athletic Equipment'
    a.account_number = '183'
    a.description = "Also Tailoring, Lawn, Cleaning"
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Tennis Facilities'
    a.account_number = '184'
    a.description = "Also Basketball Facilities"
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Delivery Equipment'
    a.account_number = '185'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Exercise Equipment'
    a.account_number = '186'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Computer Equipment'
    a.account_number = '187'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Accumulated Depreciation'
    a.account_number = '188'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = true
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 190s - Intangibles

Account.create! do |a|
    a.user_id = 1
    a.name = 'Patents'
    a.account_number = '191'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"


Account.create! do |a|
    a.user_id = 1
    a.name = 'Copyrights'
    a.account_number = '192'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Organization Costs'
    a.account_number = '193'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# Liabilities (200-299)

Account.create! do |a|
    a.user_id = 1
    a.name = 'Notes Payable'
    a.account_number = '201'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Accounts Payable'
    a.account_number = '202'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'United Way Contribution Payable'
    a.account_number = '203'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Income Tax Payable'
    a.account_number = '204'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Common Dividends Payable'
    a.account_number = '205'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Preferred Dividends Payable'
    a.account_number = '206'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Interest Payable'
    a.account_number = '207'
    a.description = "Also Bond Interest Payable"
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 2010s - Employee Payroll Related Payables

Account.create! do |a|
    a.user_id = 1
    a.name = 'Employee Income Tax Payable'
    a.account_number = '211'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Social Security Tax Payable'
    a.account_number = '212'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Medicare Tax Payable'
    a.account_number = '213'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'City Earnings Tax Payable'
    a.account_number = '215'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"
Account.create! do |a|
    a.user_id = 1
    a.name = 'Health Insurance Premiums Payable'
    a.account_number = '216'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Credit Union Payable'
    a.account_number = '217'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Savings Bond Deductions Payable'
    a.account_number = '218'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Wages Payable'
    a.account_number = '219'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 220s - Employer Payroll Related Payables

Account.create! do |a|
    a.user_id = 1
    a.name = 'FUTA Tax Payable'
    a.account_number = '221'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'SUTA Tax Payable'
    a.account_number = '222'
    a.description = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"


Account.create! do |a|
    a.user_id = 1
    a.name = "Worker\'s Compensation Insurance Payable"
    a.account_number = '223'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 230s - Sales Tax

Account.create! do |a|
    a.user_id = 1
    a.name = 'Sales Tax Payable'
    a.account_number = '231'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 240s - Deferred Revenues and Current Portion of Long-Term Debt

Account.create! do |a|
    a.user_id = 1
    a.name = 'Unearned Subscription Revenue'
    a.account_number = '241'
    a.description = "Also Unearned Ticket Revenue, Unearned Repair Fees"
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Current Portion of Mortgage Payable'
    a.account_number = '242'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# No generic Unearned Revenue in Chart of Accounts, but one is used in the solved problem.
# The solved problem journalizes Unearned Revenue, and not Unearned Subscription Revenue.
# Creating this account just in case it's needed.
Account.create! do |a|
    a.user_id = 1
    a.name = 'Unearned Revenue'
    a.account_number = '243'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Current'
    a.initial_balance = 0 # This must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 250s - Long-Term Liabilities

Account.create! do |a|
    a.user_id = 1
    a.name = 'Mortgage Payable'
    a.account_number = '251'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Premium on Bonds Payable'
    a.account_number = '253'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Liability'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# Owner's Equity (300-399)

Account.create! do |a|
    a.user_id = 1
    a.name = 'Jessica Jane, Capital'
    a.account_number = '311'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Equity'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Jessica Jane, Drawing'
    a.account_number = '312'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Equity'
    a.subcategory = 'Current'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = true
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Income Summary'
    a.account_number = '313'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Common Stock'
    a.account_number = '321'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Equity'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Paid in Capital in Excess of Par/Stated Value - Common Stock'
    a.account_number = '322'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Equity'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Preferred Stock'
    a.account_number = '323'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Equity'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"


Account.create! do |a|
    a.user_id = 1
    a.name = 'Paid in Capital in Excess of Par/Stated Value - Preferred Stock'
    a.account_number = '324'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Equity'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Retained Earnings'
    a.account_number = '325'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# Account 326 is named "Retained Earnings Appropriated for..."
# Based on this text, I believe that it is referring to 327-329. For example, 327 is named "Common Stock Subscribed",
# so the account appears in the below code as Retaiend Earnings Appropriated for Common Stock Subscribed.

Account.create! do |a|
    a.user_id = 1
    a.name = 'Retained Earnings Appropriated for Common Stock Subscribed'
    a.account_number = '327'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Retained Earnings Appropriated for Preferred Stock Subscribed'
    a.account_number = '328'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Retained Earnings Appropriated for Paid in Capital from Sale of Tresury Stock'
    a.account_number = '329'
    a.description = ""
    a.normal_side = ""
    a.category = 'Credit'
    a.subcategory = 'Revenue'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# This account was made for the solved problem. It did not exist in the Chart of Accounts file.
Account.create! do |a|
    a.user_id = 1
    a.name = 'Contributed Capital'
    a.account_number = '330'
    a.description = ""
    a.normal_side = ""
    a.category = 'Credit'
    a.subcategory = 'Revenue'
    a.initial_balance = 0 # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# Revenues (400-499)

# 400s - Operating Revenues

Account.create! do |a|
    a.user_id = 1
    a.name = 'Fees and Sales'
    a.account_number = '401'
    a.description = "Fees include delivery fees, appraisal fees, medical fees, services fees, and repair fees"
    a.normal_side = ""
    a.category = 'Credit'
    a.subcategory = 'Revenue'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Boarding and Grooming Revenue'
    a.account_number = '402'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Subscriptions Revenue - Main line of business'
    a.account_number = '403'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# Not in Chart of Accounts, but is in solved problem

Account.create! do |a|
    a.user_id = 1
    a.name = 'Service Revenue'
    a.account_number = '404'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0 # Needs to start at 0 for testing with solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"


# 410s - Other Revenues

Account.create! do |a|
    a.user_id = 1
    a.name = 'Interest Revenue'
    a.account_number = '411'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Rent Revenue'
    a.account_number = '412'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Subscriptions Revenue - Not main line of business'
    a.account_number = '413'
    a.description = "Credit"
    a.normal_side = "Revenue"
    a.category = ''
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Sinking Fund Earnings'
    a.account_number = '414'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Asset'
    a.subcategory = 'Long Term'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Uncollectible Accounts Recovered'
    a.account_number = '415'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Gain on Sale/Exchange of Equipment'
    a.account_number = '416'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Gain on Bonds Redeemed'
    a.account_number = '417'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Revenue'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# Operating Expenses (500-599)

# 500s - Cost of Goods Sold

Account.create! do |a|
    a.user_id = 1
    a.name = 'Purchases'
    a.account_number = '501'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Freight-In'
    a.account_number = '502'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Overhead'
    a.account_number = '504'
    a.description = ""
    a.normal_side = "Debit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Cost of Goods Sold'
    a.account_number = '505'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 510s - Selling Expenses

Account.create! do |a|
    a.user_id = 1
    a.name = 'Wages Expenses'
    a.account_number = '511'
    a.description = "Also Wages and Salaries Expense"
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Advertising Expense'
    a.account_number = '512'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0 # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Bank Credit Card Expense'
    a.account_number = '513'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Store Supplies Expense'
    a.account_number = '514'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Travel and Entertainment Expense'
    a.account_number = '515'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Cash Short and Over'
    a.account_number = '516'
    a.description = ""
    a.normal_side = ""
    a.category = ''
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Depreciation Expense - Store Equipment and Fixtures'
    a.account_number = '519'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Depreciation Expense'
    a.account_number = '520'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 520s-40s - General and Administrative Expenses

# Not in Chart of Accounts, but is in solved problem

Account.create! do |a|
    a.user_id = 1
    a.name = 'Rent Expense'
    a.account_number = '521'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0 # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Office Salaries Expense'
    a.account_number = '522'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Office Supplies Expense'
    a.account_number = '523'
    a.description = "Also Medical"
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Other Supplies: Food Supplies Expense'
    a.account_number = '524'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Telephone Expense'
    a.account_number = '525'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0 # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Transportation/Automobile Expense'
    a.account_number = '526'
    a.description = "Also Laboratory, Travel"
    a.normal_side = ""
    a.category = 'Credit'
    a.subcategory = 'Expense'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Collection Expense'
    a.account_number = '527'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Inventory Short and Over'
    a.account_number = '528'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Loss on Write Down of Inventory'
    a.account_number = '529'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Payroll Taxes Expense'
    a.account_number = '530'
    a.description = ""
    a.normal_side = ""
    a.category = 'Credit'
    a.subcategory = 'Expense'
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = "Workers\' Compensation Insurance Expense"
    a.account_number = '531'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Bad Debt Expense'
    a.account_number = '532'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Electricity Expense, Utilities Expense'
    a.account_number = '533'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Charitable Contributions Expense'
    a.account_number = '534'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Insurance Expense'
    a.account_number = '535'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0 # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Postage Expense'
    a.account_number = '536'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Repair Expense'
    a.account_number = '537'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Oil and Gas Expense'
    a.account_number = '538'
    a.description = "Also Automobile Expense"
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Depreciation Expense - Building'
    a.account_number = '540'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Depreciation Expense - Equipment'
    a.account_number = '541'
    a.description = "Also Tennis Facilities, Delivery Equipment, Office Equipment, Furniture"
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Depreciation Expense - Other Equipment'
    a.account_number = '542'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Depletion Expense'
    a.account_number = '543'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Patent Amortization'
    a.account_number = '544'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Amortization of Organization Costs'
    a.account_number = '545'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Miscellaneous Expense'
    a.account_number = '549'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# 550s - Other Expenses

Account.create! do |a|
    a.user_id = 1
    a.name = 'Salaries Expense'
    a.account_number = '550'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0 # Must start at 0 for testing with the solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Interest Expense'
    a.account_number = '551'
    a.description = "Also Bond Interest Expense"
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Loss on Discarded Equipment'
    a.account_number = '552'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Loss on Sale/Exchange of Equipment'
    a.account_number = '553'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Loss on Bonds Redeemed'
    a.account_number = '554'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

Account.create! do |a|
    a.user_id = 1
    a.name = 'Income Tax Expense'
    a.account_number = '555'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# Not in Chart of Accounts document, but is in solved problem document
Account.create! do |a|
    a.user_id = 1
    a.name = 'Utilities Expense'
    a.account_number = '556'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0 # Must start at 0 to test with solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# Not in Chart of Accounts document, but is in solved problem document

# This account appears on the income statement
Account.create! do |a|
    a.user_id = 1
    a.name = 'Supplies Expense'
    a.account_number = '557'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0 # Must start at 0 to test with solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end
puts "Created account: #{Account.last.name}"

# Not in Chart of Accounts document, but is in solved problem document
# Appears on Income Statement
Account.create! do |a|
    a.user_id = 1
    a.name = 'Salaries Payable'
    a.account_number = '558'
    a.description = ""
    a.normal_side = "Credit"
    a.category = 'Expense'
    a.subcategory = ''
    a.initial_balance = 0 # Must start at 0 to test with solved problem
    a.debit = 0
    a.credit = 0
    a.balance = 0
    a.order = 0
    a.statement = 0
    a.comment = 0
    a.contra = false
    a.active = true
end

puts "Created a total of #{Account.all.count} new accounts------------------------" 

# Sample journal entries. These entries are from the solved problem document.

# JournalEntry.create! do |a|
#     a.user_id = 3
#     a.debit_account = [Account.find_by(name: "Cash").id]
#     a.credit_account = [Account.find_by(name: "Notes Receivable").id]
#     a.debit_total = ["100"]
#     a.credit_total = ["100"]
#     a.entry_type = "Regular"
#     a.status = "Pending"
#     a.description = ""
#     a.date_added = Time.now
# end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Cash").id, Account.find_by(name: "Accounts Receivable").id, Account.find_by(name: "Supplies").id, Account.find_by(name: "Office Equipment")]
    a.credit_account = [Account.find_by(name: "Contributed Capital").id]
    a.debit_total = ["10000", "1500", "1250", "7500"]
    a.credit_total = ["20250"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "Assets received from John Addams on April 4."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Prepaid Rent").id]
    a.credit_account = [Account.find_by(name: "Cash").id]
    a.debit_total = ["4500"]
    a.credit_total = ["4500"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "Paid three month\'s rent on a lease rental contract on April 4."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Prepaid Rent").id]
    a.credit_account = [Account.find_by(name: "Cash").id]
    a.debit_total = ["4500"]
    a.credit_total = ["4500"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "Paid premium on property and casualty insurance policies for the year. Paid on April 4."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Cash").id]
    a.credit_account = [Account.find_by(name: "Unearned Revenue").id]
    a.debit_total = ["3000"]
    a.credit_total = ["3000"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "Received cash from clients as an advance payment for services to be provided. Advance received on April 6."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Office Equipment").id]
    a.credit_account = [Account.find_by(name: "Accounts Payable").id]
    a.debit_total = ["1800"]
    a.credit_total = ["1800"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "Purchased additional office furniture on account from Morrilton Company on April 7."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Cash").id]
    a.credit_account = [Account.find_by(name: "Accounts Receivable").id]
    a.debit_total = ["800"]
    a.credit_total = ["800"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "Received cash from clients on account. Received April 8."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Advertising Expense").id]
    a.credit_account = [Account.find_by(name: "Cash").id]
    a.debit_total = ["120"]
    a.credit_total = ["120"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "Prepaid cash for newspaper advertisement on April 11"
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Accounts Payable").id]
    a.credit_account = [Account.find_by(name: "Cash").id]
    a.debit_total = ["800"]
    a.credit_total = ["800"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "Paid Morrilton Company $800 for debt incurred on April 7. Payment given on April 12."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Accounts Receivable").id]
    a.credit_account = [Account.find_by(name: "Service Revenue").id]
    a.debit_total = ["2250"]
    a.credit_total = ["2250"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 15 - Recorded Services provided on account for April 18-22, $1,100."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Salaries Expense").id]
    a.credit_account = [Account.find_by(name: "Cash").id]
    a.debit_total = ["400"]
    a.credit_total = ["400"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 15 - Paid part-time receptionist for two weeks salary, $400."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Cash").id]
    a.credit_account = [Account.find_by(name: "Service Revenue").id]
    a.debit_total = ["3175"]
    a.credit_total = ["3175"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 15 - Recorded cash from cleints for fees earned April 14-15, $3,175"
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Supplies").id]
    a.credit_account = [Account.find_by(name: "Cash").id]
    a.debit_total = ["750"]
    a.credit_total = ["750"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 18 - Paid cash for newspaper advertisement, $120."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Accounts Receivable").id]
    a.credit_account = [Account.find_by(name: "Service Revenue").id]
    a.debit_total = ["1850"]
    a.credit_total = ["1850"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 22 - Recorded services provided on account for April 18-22, $1,100."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Cash").id]
    a.credit_account = [Account.find_by(name: "Accounts Receivable").id]
    a.debit_total = ["1600"]
    a.credit_total = ["1600"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 22 - Recorded cash from cash clients for fees earned April 18-22, $1,850."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Cash").id]
    a.credit_account = [Account.find_by(name: "Accounts Receivable").id]
    a.debit_total = ["1600"]
    a.credit_total = ["1600"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 25 - Received cash from clients on account, $1600."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Salaries Expense").id]
    a.credit_account = [Account.find_by(name: "Cash").id]
    a.debit_total = ["400"]
    a.credit_total = ["400"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "Paid part-time receptionist for two week's salary, $400."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Telephone Expense").id]
    a.credit_account = [Account.find_by(name: "Cash").id]
    a.debit_total = ["130"]
    a.credit_total = ["130"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 28 - Paid telephone bill for April, $130."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Utilities Expense").id]
    a.credit_account = [Account.find_by(name: "Cash").id]
    a.debit_total = ["200"]
    a.credit_total = ["200"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 29 - Paid electric bill for April, $200."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Cash").id]
    a.credit_account = [Account.find_by(name: "Service Revenue").id]
    a.debit_total = ["2050"]
    a.credit_total = ["2050"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 29 - Recorded cash from cash clients for fees earned April 25-29, $2,050."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Accounts Receivable").id]
    a.credit_account = [Account.find_by(name: "Service Revenue").id]
    a.debit_total = ["1000"]
    a.credit_total = ["1000"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 29 - Recorded services provided on account for April 25-29, $1,000."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Salaries Expense").id]
    a.credit_account = [Account.find_by(name: "Cash").id]
    a.debit_total = ["4500"]
    a.credit_total = ["4500"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = "April 29 - John received $4,500 from the company as his salary."
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Insurance Expense").id]
    a.credit_account = [Account.find_by(name: "Prepaid Insurance").id]
    a.debit_total = ["150"]
    a.credit_total = ["150"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = ""
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Supplies Expense").id]
    a.credit_account = [Account.find_by(name: "Supplies").id]
    a.debit_total = ["980"]
    a.credit_total = ["980"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = ""
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Depreciation Expense").id]
    a.credit_account = [Account.find_by(name: "Accumulated Depreciation").id]
    a.debit_total = ["500"]
    a.credit_total = ["500"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = ""
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Salaries Expense").id]
    a.credit_account = [Account.find_by(name: "Salaries Payable").id]
    a.debit_total = ["20"]
    a.credit_total = ["20"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = ""
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Rent Expense").id]
    a.credit_account = [Account.find_by(name: "Prepaid Rent").id]
    a.debit_total = ["1500"]
    a.credit_total = ["1500"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = ""
    a.date_added = Time.now
end

JournalEntry.create! do |a|
    a.user_id = 3
    a.debit_account = [Account.find_by(name: "Unearned Revenue").id]
    a.credit_account = [Account.find_by(name: "Service Revenue").id]
    a.debit_total = ["2000"]
    a.credit_total = ["2000"]
    a.entry_type = "Regular"
    a.status = "Pending"
    a.description = ""
    a.date_added = Time.now
end

puts "Created journal entries"

# JournalEntry.create! do |a|
#     a.user_id = 3
#     a.debit_account = [Account.find_by(name: "").id]
#     a.credit_account = [Account.find_by(name: "").id]
#     a.debit_total = [""]
#     a.credit_total = [""]
#     a.entry_type = "Regular"
#     a.status = "Pending"
#     a.description = ""
#     a.date_added = Time.now
# end

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
