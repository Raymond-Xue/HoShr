require 'bcrypt'
class User < ApplicationRecord
	has_many :property
	has_many :lessor_request, :through => :property	
	has_many :lessee_request
  belongs_to :current_group, foreign_key: :current_group_id, class_name: "Group"
  belongs_to :origin_group , foreign_key: :origin_group_id, class_name: "Group"
	before_save { self.email = email.downcase }
    validates :username, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
    has_secure_password
  # validates :password, presence: true, length: { minimum: 6 }

	# Returns the hash digest of the given string.
    def User.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
end
