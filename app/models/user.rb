class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence:true
  after_initialize :ensure_token_created!
  # after_initialize do |user|
  #   self.session_token ||= SecureRandom::urlsafe_base64(16)
  # end

  has_many(
    :cats,
    class_name: "Cat",
    foreign_key: :user_id,
    primary_key: :id
  )

  def self.find_by_credentials(username, password)
    user = User.find_by_user_name(username)
    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(16)
    self.save!
  end

  def password=(password)
    @password = BCrypt::Password.create(password)
    self.password_digest = @password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  private
  def ensure_token_created!
    self.session_token ||= SecureRandom::urlsafe_base64(16)
  end

end
