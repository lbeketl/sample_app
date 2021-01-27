class User < ApplicationRecord
    attr_accessor :remember_token

    before_save { self.email = self.email.downcase }
    validates(:name, presence: true, length: { maximum: 50 })
        VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates(:email, presence: true, length: { maximum: 255}, 
        format: { with: VALID_EMAIL_REGEX},
        uniqueness: { case_sensitive: false})
    has_secure_password
    validates :password, length: { minimum: 6 }
    
    # Повертає дайдест для даного рядка
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
        end
    
    #Повертає випадковий токен
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    #Запамятовує користувача в базі даних для використання в постійних сеансах
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    #Повертає true  якщо вказадний токен відповідає дайджету
    def authenticated?(remember_token)
        if remember_digest.nil?
            false
        else
            BCrypt::Password.new(remember_digest).is_password?(remember_token)
        end
    end

    # Забуває користувача
    def forget
        update_attribute(:remember_digest, nil)
    end

end
