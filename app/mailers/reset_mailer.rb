class ResetMailer < ApplicationMailer
  def reset_password
    @user = params[:user]
    @url = "http://localhost:3000/password/reset" + "?token=" + @user.reset
    mail(to: @user.email, subject: "Reset Password for MoneyBinder")
  end

  def approve_new_account
    @user = params[:user]
    @url = "http://localhost:3000/user/edit/#{@user.id}"
    mail(to: 'evanjdillon@gmail.com', subject: "New Account Request")
  end

  def account_activated
    @user = params[:user]
    @url = "http://localhost:3000/welcome"
    mail(to: @user.email, subject: "Your account has been approved")
  end

  def send_this
    @user = params[:user]
    @subject = params[:subject]
    @body = params[:body]
    mail(to: @user.email, subject: @subject)
  end
end
