# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
first_beverage = Beverage.create!(is_active: false, name: 'Refrigerante lata', description: 'teste', calories: 300, alcoholic: false, restaurant: restaurant)
ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
ItemOption.create!(description: 'Coca-cola 500ml', price: 6.00,item: first_beverage)
ItemOption.create!(description: 'Fanta 500ml',price: 5.00, item: first_beverage)
menu = Menu.create!(name: 'Lanches', restaurant: restaurant)
MenuItem.create!(menu: menu, item: first_dish)
MenuItem.create!(menu: menu, item: first_beverage)
Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)