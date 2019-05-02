class User < ApplicationRecord
    has_secure_password
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

    def certification(name,token)
        result = false
        if token == User.find_by(name: name).remember_digest
            result = true
        end
        return result
    end
end
