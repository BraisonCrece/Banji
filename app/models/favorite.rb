class Favorite < ApplicationRecord
  validates :user, uniqueness: { scope: :product }

  belongs_to :user, dependent: :destroy
  belongs_to :product, dependent: :destroy
end
