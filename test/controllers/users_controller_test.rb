require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # Tests for create method
  test "should create Accountant user" do
    get user_create_path, 
      params: { 
        firstName: "Test", 
        lastName: "Accountant", 
        password: "password#1",
        userType: 3,
        email: "test@gmail.com",
        phoneNum: "7701234567",
        address: "123 Street Ave",
        active: true,
        security_question_1: { id: 1},
        security_question_answer: "ATL"
      }

    assert_redirected_to user_management_path
    assert_equal "User has been Created", flash[:success]  
    assert_equal 1, User.where(firstName: "Test", userType: 3).count
  end

  test "should create Manager user" do
    get user_create_path, 
      params: { 
        firstName: "Test", 
        lastName: "Manager", 
        password: "password#1",
        userType: 2,
        email: "test@gmail.com",
        phoneNum: "7701234567",
        address: "123 Street Ave",
        active: true,
        security_question_1: { id: 1},
        security_question_answer: "ATL"
      }

    assert_redirected_to user_management_path
    assert_equal "User has been Created", flash[:success]  
    assert_equal 1, User.where(firstName: "Test", userType: 2).count
  end

  test "should create Admin user" do
    get user_create_path, 
      params: { 
        firstName: "Test", 
        lastName: "Admin", 
        password: "password#1",
        userType: 1,
        email: "test@gmail.com",
        phoneNum: "7701234567",
        address: "123 Street Ave",
        active: true,
        security_question_1: { id: SecurityQuestion.first.id},
        security_question_answer: "ATL"
      }

    assert_redirected_to user_management_path
    assert_equal "User has been Created", flash[:success]  
    assert_equal 1, User.where(firstName: "Test", userType: 1).count
    assert_equal 1, PasswordJoinAuthorization.all.count
  end

  test "should create a password authorization" do
    get user_create_path, 
      params: { 
        firstName: "Test", 
        lastName: "Admin", 
        password: "password#1",
        userType: 1,
        email: "test@gmail.com",
        phoneNum: "7701234567",
        address: "123 Street Ave",
        active: true,
        security_question_1: { id: SecurityQuestion.first.id},
        security_question_answer: "ATL"
      }

    assert_equal 1, PasswordJoinAuthorization.where(answer: "ATL").count
  end





  test "should not create user if password is shorter than 8 characters" do
    get user_create_path, 
      params: { 
        firstName: "Test",
        password: "pass"
      }
    assert_redirected_to new_user_path
    assert_equal "Password needs to be at least 8 characters. \n", flash[:danger]  
    assert_equal 0, User.where(firstName: "Test").count
  end

  test "should not create user if password has no number" do
    get user_create_path, 
      params: { 
        firstName: "Test",
        password: "password$#"
      }
    assert_redirected_to new_user_path
    assert_equal "Password must have a letter, a number, and a special character. \n", flash[:danger]  
    assert_equal 0, User.where(firstName: "Test").count
  end

  test "should not create user if password has no special character" do
    get user_create_path, 
      params: { 
        firstName: "Test",
        password: "password12"
      }
    assert_redirected_to new_user_path
    assert_equal "Password must have a letter, a number, and a special character. \n", flash[:danger]  
    assert_equal 0, User.where(firstName: "Test").count
  end



  test "should not create new user if username already exists" do
    get user_create_path, 
      params: { 
        firstName: "C", 
        lastName: "User", 
        password: "password#1",
        security_question_1: { id: 1},
        security_question_answer: "ATL"
      }

      get user_create_path, 
      params: { 
        firstName: "C", 
        lastName: "User", 
        password: "password#1",
        security_question_1: { id: 1},
        security_question_answer: "ATL"
      }
    
    assert_redirected_to new_user_path
    assert_equal "Username has already been taken", flash[:danger]  
    assert_equal 1, User.where(firstName: "C").count
  end

  test "should not create user if email already exists" do
    get user_create_path, 
      params: { 
        firstName: "Test", 
        lastName: "User", 
        password: "password#1",
        email: "emailthatexists@gmail.com"
      }
    
    assert_redirected_to new_user_path
    assert_equal "Email has already been taken", flash[:danger]  
    assert_equal 0, User.where(firstName: "Test").count
  end

  test "should create correct username" do
    get user_create_path, 
      params: { 
        firstName: "Username", 
        lastName: "Test", 
        password: "password#1",
        security_question_1: { id: 1},
        security_question_answer: "ATL"
      }
    assert_equal 1, User.where(username: "UTest#{Time.now.strftime("%m")}#{Time.now.strftime("%y")}").count
  end


  # Tests for Update method
  test "should update user" do
    # get edit_user_path(User.find_by(username: "UpdateMe")), 
    #   params: {
    #     firstName: "New", 
    #     lastName: "User", 
    #     active: false
    #   }
    # assert_equal 1, User.where(firstName: "New", lastName: "User", active: false).count
  end

  test "should not let user update username if already exists" do
  end

  test "should kickout user if they deactivate their account" do
  end

  test "should suspend user" do
  end

  test "should un-suspend user" do
  end

  test "should kick user if they suspend their account" do
  end

  test "should send email new user after activated" do
  end
  


  # Tests administrator_email method
  test "should send email to user" do
  end

  test "should send email with no subject or body" do
  end
end