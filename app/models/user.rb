
# app/models/user.rb
class User < ApplicationRecord
  has_secure_password

  has_many :orders, dependent: :destroy

  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  # Role Helper Methods
  def admin?
    role == "admin"
  end

  def customer?
    role == "customer"
  end
end