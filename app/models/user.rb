class User < ApplicationRecord
  has_secure_password
  validates :username, presence:true, uniqueness: true, 
    length: { in: 5..15 },
    format: { 
      with: /\A[a-z-0-9-A-Z]+\z/,
      message: :invalid
     }
  validates :email, :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }
end
