class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 30 }
  # Validating the email format with a regular expression. the code ensures that only email addresses that match the pattern will be considered valid.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX},  uniqueness: { case_sensitive: false }
  has_secure_password #Presence validations for the password and its confirmation are automatically added by this.
  validates :password, length: {minimum: 6}


end
