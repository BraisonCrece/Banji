class Product < ApplicationRecord
    has_many_attached :images
    validates :title, :description, :price, presence: true
end
