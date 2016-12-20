class User < ApplicationRecord

  attr_accessor :remember_token, :activation_token, :reset_token

  # Ensures that the user's confirmation token is inserted into the table
  # Before the user is fully created
  before_create :confirmation_token

  attr_accessor :password
  EMAIL_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  validates :user_name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create

  before_save :encrypt_password
  after_save  :clear_password
#encryption
  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end

#clear the password
  def clear_password
    self.password = nil
  end

#For the purposes of authenticating users
  def self.authenticate(username_or_email="", login_password="")
    if  EMAIL_REGEX.match(username_or_email)
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_user_name(username_or_email)
    end
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end

  def match_password(login_password="")
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

#Sets password reset attributes
def create_reset_digest
  self.reset_token = SecureRandom.urlsafe_base64.to_s
  update_attribute(:reset_digest, BCrypt::Engine.hash_secret(reset_token, salt))
  update_attribute(:reset_sent_at, Time.zone.now)
end

# Sends password reset email.
def send_password_reset_email
  UserMailer.password_reset(self).deliver_now
end

#Confirm token for emails confirmation
private
  def confirmation_token
      if self.confirm_token.blank?
          self.confirm_token = SecureRandom.urlsafe_base64.to_s
      end
  end

end
