# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'net/http'
require 'json'

puts " Limpiando base de datos..."
ActiveRecord::Base.connection.disable_referential_integrity do
  Payment.destroy_all
  CartProduct.destroy_all
  Cart.destroy_all
  Product.destroy_all
  User.destroy_all
end

puts " Creando usuario vendedor..."
seller = User.create!(
  email: "seller@techmarket.com",
  name: "Tech Seller",
  password: "password123",
  password_confirmation: "password123",
  address: "123 Tech Street, Silicon Valley",
  phone_number: "+11234567890",
  birth_date: Date.new(1980, 1, 1)
)

puts " Creando usuario comprador..."
buyer = User.create!(
  email: "buyer@techmarket.com",
  name: "Tech Buyer",
  password: "password123",
  password_confirmation: "password123",
  address: "456 Consumer Ave, Silicon Valley",
  phone_number: "+10987654321",
  birth_date: Date.new(1990, 5, 15)
)

def fetch_dummyjson_laptops
  uri = URI("https://dummyjson.com/products/category/laptops")
  response = Net::HTTP.get(uri)
  JSON.parse(response)['products']
rescue StandardError => e
  puts " Error obteniendo laptops: #{e.message}"
  []
end

def fetch_fakestore_electronics
  uri = URI("https://fakestoreapi.com/products/category/electronics")
  response = Net::HTTP.get(uri)
  JSON.parse(response)
rescue StandardError => e
  puts "⚠️ Error obteniendo electrónicos: #{e.message}"
  []
end

puts " Obteniendo productos de DummyJSON (laptops)..."
dummyjson_laptops = fetch_dummyjson_laptops

puts " Obteniendo productos de FakeStoreAPI (electrónicos)..."
fakestore_electronics = fetch_fakestore_electronics

puts " Creando productos..."
[dummyjson_laptops, fakestore_electronics].each do |products|
  products.each do |product_data|
    Product.create!(
      name: product_data['title'][0..99],
      description: product_data['description'][0..499],
      price: product_data['price'],
      image_url: product_data['images']&.first || product_data['image'],
      user: seller
    )
    print "."
  end
end

puts "\n ¡Base de datos poblada exitosamente!"
puts "   Usuarios: #{User.count}"
puts "   Productos: #{Product.count}"
