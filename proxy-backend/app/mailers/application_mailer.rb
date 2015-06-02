class ApplicationMailer < ActionMailer::Base
  default from: "noreply.test@gmail.com"
  layout 'mailer'
end
