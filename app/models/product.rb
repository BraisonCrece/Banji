class Product < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_keyword, against: [:title, :description], using: { tsearch: { prefix: true } }

  has_many_attached :images

  validates :title, :description, :price, presence: true
  belongs_to :category

  ORDER_BY = {
    "newest" => "created_at DESC",
    "cheapest" => "price ASC",
    "expensive" => "price DESC",
  }.freeze
end
