class ResetMailer < ApplicationMailer
  def reset_password
    @user = params[:user]
    @url = "#{url_address}/password/reset" + "?token=" + @user.reset
    mail(to: @user.email, subject: "Reset Password for MoneyBinder")
  end

  def approve_new_account
    @user = params[:user]
    @url = "#{url_address}/user/edit/#{@user.id}"
    mail(to: User.where(userType: 1).first.email, subject: "New Account Request")
  end

  def account_activated
    @user = params[:user]
    @url = "#{url_address}/welcome"
    mail(to: @user.email, subject: "Your account has been approved")
  end

  def send_this
    @user = params[:user]
    @subject = params[:subject]
    @body = params[:body]
    mail(to: @user.email, subject: @subject)
  end

  def pending_journal_entry
    @user = params[:user_email]
    @url = "#{url_address}/journal_entries"
    mail(to: @user, subject: "New journal entry for approval")
  end

  private
  def url_address
    if Rails.env == 'production'
      return 'https://moneybinder.herokuapp.com/'
    else
      return 'http://localhost:3000'
    end
  end
end
