class UserMailer < ApplicationMailer
  def noproxy_email
    mail(to: ENV['RECEIVE_EMAIL'], subject: "no more valid proxy exists")
  end
end
