class User < ApplicationRecord
    has_secure_password
    
    before_create :generate_token
    validates :email, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }


    def generate_token
        self.token = loop do
          random_token = SecureRandom.urlsafe_base64(nil, false)
          break random_token unless User.exists?(token: random_token)
        end
    end
end
