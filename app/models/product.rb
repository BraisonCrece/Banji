class Product < ApplicationRecord
  include PgSearch::Model
  validates :title, :description, :price, presence: true
  
  belongs_to :category
  
  belongs_to :user, default: -> { Current.user }

  pg_search_scope :search_by_keyword, against: [:title, :description], using: { tsearch: { prefix: true } }

  has_many_attached :images


  ORDER_BY = {
    "newest" => "created_at DESC",
    "cheapest" => "price ASC",
    "expensive" => "price DESC",
  }.freeze

  def owner?
    user_id == Current.user&.id
  end
  
end
