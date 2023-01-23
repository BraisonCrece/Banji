# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'net/http'
require 'open-uri'
require 'faker'


admin = User.new(email: "admin@banji.dev", username: "admin", password: "password", admin: true)
url = URI(Faker::Avatar.image(slug: "admin_avatar", size: "150x150"))
response = Net::HTTP.get(url)
admin.avatar.attach(io: StringIO.new(response), filename: "image.jpg")
admin.save


Category.create(name: "Electronics")
Category.create(name: "Home")
Category.create(name: "Cars")
Category.create(name: "Bicicles")
Category.create(name: "Cellphones")
Category.create(name: "TVs")
Category.create(name: "Computers")
Category.create(name: "Motorcycles")

10.times do |index|
  pp "#{index} user created"
  user = User.new(email: Faker::Internet.email(name: "user#{index+1}"), username: "user#{index+1}", password: Faker::Internet.password)
  pp user
  url = URI(Faker::Avatar.image(slug: "avatar", size: "150x150"))
  response = Net::HTTP.get(url)
  user.avatar.attach(io: StringIO.new(response), filename: "image_#{index}.jpg")
  user.save
  pp user.errors.full_messages
end

User.all.each do |user, i|
  3.times do 
    product = Product.new(title: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, price: Faker::Commerce.price, user_id: user.id, category_id: Category.all.sample.id)
    3.times do |j|
      product.images.attach(io: File.open("app/assets/images/clio#{j+1}.webp"), filename: "clio#{j+1}.webp")
      product.save
    end
  end
  
  
  
  
  
end


