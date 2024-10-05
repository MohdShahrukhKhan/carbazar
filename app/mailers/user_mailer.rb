# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  # default from: 'Car Bazaar'

  def login_notification(user)
    @user = user
    mail(to: @user.email, subject: 'Login Notification')
  end
end