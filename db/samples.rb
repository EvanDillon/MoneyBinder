# Generate sample users
# require 'bcrypt'

# Created Evan User
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
    a.firstName = 'A'
    a.lastName = 'dmin'
    a.username = 'Admin'
    a.password = "password"
    a.userType = 1
    a.email = 'test@gmail.com'
    a.phoneNum = '7705555555'
    a.address = '555 Test Street'
    a.active = true
    a.suspendedTill = Time.now
end
puts "Created Admin" 


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
