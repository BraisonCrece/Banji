class Product < ApplicationRecord
    validates :title, :description, :price, presence: true
end
