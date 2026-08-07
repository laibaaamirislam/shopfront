
class User < ApplicationRecord
  has_secure_password
  has_many :orders

  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  def admin?
    role == "admin"
  end                 
  
end