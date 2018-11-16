class User < ApplicationRecord

  after_initialize :ensure_session_token ###   ???

  validates :email, :password_digest, :session_token, presence: true, uniqueness: true
  validates :password, length: {minimum: 6, allow_nil: true}
#  validates :password_digest, presence: {message: 'Password cannot be blank'}

  def self.find_by_credentials(email, password)

    user = User.find_by(email: email)
    return user if user.is_password?(password)

  end

  def self.generate_session_token
    Secure::Random.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save! # ????
    self.session_token # ????
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    # user = User.
    # user.password_digest == BCrypt::Password.create(password)
    BCrypt::Password.new(self.password_digest) == password
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

end
