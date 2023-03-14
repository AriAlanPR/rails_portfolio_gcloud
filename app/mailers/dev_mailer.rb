class DevMailer < ApplicationMailer
    default from: 'alanpromerogit@gmail.com'

  def greeting_email(target)
    @user = 'alanpromerogit@gmail.com'
    @url  = 'rails.alanperezweb.xyz'
    mail(to: target, subject: 'Greetings from my Portfolio Site')
  end
end
