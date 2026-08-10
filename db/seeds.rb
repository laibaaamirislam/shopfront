# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb
# Run with: rails db:seed
# Clears existing Products and Categories first, then reseeds from scratch.

if Rails.env.production?
  raise "Refusing to run destructive seeds in production. Remove this guard if you really mean to."
end

# db/seeds.rb

puts "Seeding users..."

# Creates the admin if missing, or updates credentials if present
# db/seeds.rb
admin = User.find_or_create_by!(email: "thisislaibaamir@gmail.com") do |u|
  u.username = "admin"
  u.password = "password123"
  u.role = "admin"
end

customer = User.find_or_create_by!(email: "amirlaiba546@gmail.com") do |u|
  u.username = "laiba"
  u.password = "password123"
  u.role = "customer"
end

puts "Done! Seeded Admin (#{admin.email}) and Customer (#{customer.email})."

categories = {
  "Earrings"   => Category.find_or_create_by!(name: "Earrings"),
  "Mugs"       => Category.find_or_create_by!(name: "Mugs"),
  "Planters"   => Category.find_or_create_by!(name: "Planters"),
  "Bowls"      => Category.find_or_create_by!(name: "Bowls"),
  "Home Decor" => Category.find_or_create_by!(name: "Home Decor")
}

products = [
  { name: "Terracotta Hoop Earrings",        description: "Lightweight hoops in a warm, unglazed terracotta finish.", price: 18.00, stock_quantity: 12, sku: "ER-1001", category: "Earrings" },
  { name: "Ceramic Stud Earrings, Set of 3", description: "Three minimalist stud pairs in matte glaze — pink, sage, and cream.", price: 22.00, stock_quantity: 20, sku: "ER-1002", category: "Earrings" },

  { name: "Hand-thrown Stoneware Mug",       description: "A generous 12oz mug with a soft matte glaze, comfortable handle.", price: 28.00, stock_quantity: 15, sku: "MG-2001", category: "Mugs" },
  { name: "Speckled Espresso Cup",           description: "A small speckled cup for espresso or a short pour-over.", price: 14.00, stock_quantity: 25, sku: "MG-2002", category: "Mugs" },

  { name: "Small Terracotta Planter (4\")",  description: "Classic unglazed terracotta with a drainage hole, fits most 4-inch nursery pots.", price: 16.00, stock_quantity: 30, sku: "PL-3001", category: "Planters" },
  { name: "Hanging Ceramic Planter",         description: "Glazed hanging planter with woven cotton cord, for trailing plants.", price: 32.00, stock_quantity: 10, sku: "PL-3002", category: "Planters" },

  { name: "Wide Serving Bowl",               description: "A wide, shallow bowl for salads or serving — glazed interior, raw clay exterior.", price: 45.00, stock_quantity: 8, sku: "BW-4001", category: "Bowls" },
  { name: "Small Trinket Dish",              description: "A tiny catch-all dish for rings, keys, or loose change.", price: 12.00, stock_quantity: 40, sku: "BW-4002", category: "Bowls" },

  { name: "Ceramic Vase, Tall",              description: "A tall, narrow vase with a soft crackle glaze, ideal for a single stem or dried florals.", price: 38.00, stock_quantity: 9, sku: "HD-5001", category: "Home Decor" },
  { name: "Textured Candle Holder",          description: "A ribbed ceramic candle holder for standard taper candles.", price: 20.00, stock_quantity: 18, sku: "HD-5002", category: "Home Decor" }
]

products.each do |attrs|
  category_name = attrs.delete(:category)
  product = Product.find_or_initialize_by(sku: attrs[:sku])
  product.assign_attributes(attrs.merge(category: categories[category_name]))
  product.save!
  puts "#{product.persisted? ? 'Saved' : 'Skipped'}: #{product.name}"
end

puts "\nSeeded #{Category.count} categories and #{Product.count} products."