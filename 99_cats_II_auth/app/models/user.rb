class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true
    validates :session_token, presence: true, uniqueness: true
    validates :password, presence: true, length: {minimum: 6}
    validates :password_digest, presence: true
    after_initialize :ensure_session_token

    def self.find_by_credentials(user_name, password)
        user = self.find_by(user_name: user_name)
        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

    def password
        @password
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
    end

    def is_password?(password)
        password_digest_object = BCrypt::Password.new(self.password_digest)
        password_digest_object.is_password?(password)
    end
end