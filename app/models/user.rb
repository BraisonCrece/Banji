class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar, dependent: :destroy

  validates :username, presence: true, uniqueness: true,
                       length: { in: 5..15 },
                       format: {
                         with: /\A[a-z0-9A-Z]+\z/,
                         message: :invalid,
                       }
  validates :email, presence: true, uniqueness: true,
                    format: {
                      with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                      message: :invalid,
                    }

  validates :password, length: { minimum: 6 }

  has_many :products, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  before_save :downcase_attributes

  private

  def downcase_attributes
    self.username = username.downcase
    self.email = email.downcase
  end
end
