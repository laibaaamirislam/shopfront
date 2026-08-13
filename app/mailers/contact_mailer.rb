
class ContactMailer < ApplicationMailer
  ADMIN_EMAIL = "thisislaibaamir@gmail.com"

  def contact_email(name, user_email, subject, message)
    @name    = name
    @email   = user_email
    @subject = subject.presence || "New Contact Inquiry from Shopfront"
    @message = message

    mail(
      to: ADMIN_EMAIL,
      from: "Shopfront Contact Form <#{ADMIN_EMAIL}>", 
      reply_to: @email,
      subject: "[Shopfront] #{@subject}"
    )
  end
end