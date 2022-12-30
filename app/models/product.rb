class Product < ApplicationRecord
  include PgSearch::Model
  validates :title, :description, :price, presence: true

  pg_search_scope :search_by_keyword, against: [:title, :description], using: { tsearch: { prefix: true } }

  belongs_to :category
  belongs_to :user, default: -> { Current.user }
  has_many :favorites, dependent: :destroy
  has_many_attached :images

  ORDER_BY = {
    "newest" => "created_at DESC",
    "cheapest" => "price ASC",
    "expensive" => "price DESC",
  }.freeze

  def owner?
    user_id == Current.user&.id
  end

  def favorite!
    favorites.create(user: Current.user)
  end

  def unfavorite!
    favorites.find_by(user: Current.user).destroy
  end

  def favorite?
    favorites.find_by(user: Current.user)
  end
end
