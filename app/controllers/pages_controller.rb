
# # app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def contact
  end

  def home
  end

  def about
  end

  def create_contact
    ContactMailer.contact_email(
      params[:name],
      params[:email],
      params[:subject],
      params[:message]
    ).deliver_later

    redirect_to contact_path, notice: "Thank you #{params[:name]}! Your message has been delivered."
  # rescue => e
  #   Rails.logger.error "Failed to send contact email: #{e.message}"
  #   redirect_to contact_path, alert: "Sorry, something went wrong while sending your message. Please try again."
  end
end

