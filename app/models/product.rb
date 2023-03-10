class Product < ApplicationRecord
  include PgSearch::Model
  include Favoritable

  validates :title, :description, :price, presence: true

  pg_search_scope :search_by_keyword, against: [:title, :description], using: { tsearch: { prefix: true } }

  belongs_to :category
  belongs_to :user, default: -> { Current.user }
  has_many_attached :images, dependent: :destroy

  ORDER_BY = {
    "newest" => "created_at DESC",
    "cheapest" => "price ASC",
    "expensive" => "price DESC",
  }.freeze

  def owner?
    user_id == Current.user&.id
  end
end
