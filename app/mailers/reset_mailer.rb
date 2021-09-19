class ResetMailer < ApplicationMailer
  def reset_password
    @user = params[:user]
    @url = "http://localhost:3000/password/reset" + "?token=" + @user.reset
    mail(to: @user.email, subject: "Reset Password for MoneyBinder")
  end
end
