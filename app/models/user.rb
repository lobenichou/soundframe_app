class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 30 }
  # Validating the email format with a regular expression. the code ensures that only email addresses that match the pattern will be considered valid.
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX},  uniqueness: { case_sensitive: false }
  has_secure_password #Presence validations for the password and its confirmation are automatically added by this.
  validates :password, length: {minimum: 6}

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end


end
