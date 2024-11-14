# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

restaurant = Restaurant.find_or_create_by!(corporate_name: 'Hot Lanches') do |r|
  r.brand_name = 'hot lanches'
  r.cnpj = CNPJ.generate
  r.full_address = 'Rua da Hot, 721 - RJ'
  r.email = 'contato@lancheshot.com'
  r.phone_number = '81987654321'
end
restaurant.update!(code: 'REST99')

User.find_or_create_by!(email: 'admin@gmail.com') do |user|
  user.restaurant = restaurant
  user.name = 'Admin'
  user.last_name = 'adm'
  user.cpf = CPF.generate
  user.password = 'password1234'
end

User.find_or_create_by!(email: 'employee@gmail.com') do |user|
  user.restaurant = restaurant
  user.role = :employee
  user.name = 'employee'
  user.last_name = 'emp'
  user.cpf = CPF.generate
  user.password = 'password1234'
end

first_dish = Dish.find_or_create_by!(name: 'Batata frita', restaurant: restaurant) do |dish|
  dish.description = 'testando'
  dish.calories = 10
end

first_beverage = Beverage.find_or_create_by!(name: 'Refrigerante lata', restaurant: restaurant) do |beverage|
  beverage.is_active = true
  beverage.description = 'teste'
  beverage.calories = 300
  beverage.alcoholic = false
end

first_dish_option = ItemOption.find_or_create_by!(description: 'Batata pequena') do |option|
  option.price = 10.00
  option.item = first_dish
end

second_dish_option = ItemOption.find_or_create_by!(description: 'Batata grande') do |option|
  option.price = 15.00
  option.item = first_dish
end

first_beverage_option = ItemOption.find_or_create_by!(description: 'Coca-cola 500ml') do |option|
  option.price = 6.00
  option.item = first_beverage
end

second_beverage_option = ItemOption.find_or_create_by!(description: 'Fanta 500ml') do |option|
  option.price = 5.00
  option.item = first_beverage
end

menu = Menu.find_or_create_by!(name: 'Lanches', restaurant: restaurant)

MenuItem.find_or_create_by!(menu: menu, item: first_dish)
MenuItem.find_or_create_by!(menu: menu, item: first_beverage)

customer = Customer.find_or_create_by!(email: 'cliente@gmail.com') do |cust|
  cust.name = 'Joãozinho'
  cust.phone_number = '81987654321'
  cust.cpf = CPF.generate
  cust.restaurant = restaurant
end

order_configurations = [
  [
    { item_option: first_dish_option, observation: 'sem sal' },
    { item_option: first_beverage_option }
  ],
  [
    { item_option: first_dish_option, observation: 'com cheedar' },
    { item_option: first_beverage_option }
  ],
  [
    { item_option: first_dish_option, observation: 'com cheedar' },
    { item_option: first_dish_option },
    { item_option: first_beverage_option },
    { item_option: first_beverage_option }
  ],
  [
    { item_option: first_dish_option},
    { item_option: second_dish_option },
    { item_option: second_dish_option },
    { item_option: second_beverage_option , observation: 'com gelo' },
    { item_option: first_beverage_option , observation: 'com gelo' }
  ],
  [
    { item_option: second_dish_option, observation: 'teste' },
    { item_option: first_beverage_option }
  ]
]

3.times do
  order_configurations.each do |order_items|
    o = Order.create!(customer: customer, restaurant: restaurant, order_items_attributes: order_items)
    random_hours = rand(0.1..3.0).round(2) 
    o.order_date = random_hours.hours.ago
    o.pending_kitchen!
  end
end

puts "Seed completed"