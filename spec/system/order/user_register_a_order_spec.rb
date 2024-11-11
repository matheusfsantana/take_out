require 'rails_helper'

describe 'User register a order' do
  it 'and see all fields' do
    user = User.create!(email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
    first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
    first_beverage = Beverage.create!(is_active: false, name: 'Refrigerante lata', description: 'teste', calories: 300, alcoholic: false, restaurant: restaurant)
    ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
    ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
    ItemOption.create!(description: 'Coca-cola 500ml', price: 6.00,item: first_beverage)
    ItemOption.create!(description: 'Fanta 500ml',price: 5.00, item: first_beverage)
    menu = Menu.create!(name: 'Lanches', restaurant: restaurant)
    MenuItem.create!(menu: menu, item: first_dish)
    MenuItem.create!(menu: menu, item: first_beverage)

    login_as(user)
    visit root_path
    click_on 'Lanches'
    click_on 'Registrar pedido'

    expect(current_path).to eq new_restaurant_menu_order_path(restaurant, menu)
    expect(page).to have_select 'Cliente'
    expect(page).to have_select 'Item'
    expect(page).to have_field 'Observação'
  end

  it 'and should create a new order successfully' do 
    user = User.create!(email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
    first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
    first_beverage = Beverage.create!(is_active: false, name: 'Refrigerante lata', description: 'teste', calories: 300, alcoholic: false, restaurant: restaurant)
    ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
    ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
    ItemOption.create!(description: 'Coca-cola 500ml', price: 6.00,item: first_beverage)
    ItemOption.create!(description: 'Fanta 500ml',price: 5.00, item: first_beverage)
    menu = Menu.create!(name: 'Lanches', restaurant: restaurant)
    MenuItem.create!(menu: menu, item: first_dish)
    MenuItem.create!(menu: menu, item: first_beverage)
    Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: '61354764080', restaurant: restaurant)

    login_as(user)
    visit new_restaurant_menu_order_path(restaurant, menu)
    select 'Joãozinho', from: 'Cliente'
    select 'Batata pequena - R$ 10.00', from: 'Item'
    fill_in 'Observação', with: 'colocar ketchup'
    click_on 'Registrar pedido'
    order = Order.last

    expect(current_path).to eq confirm_order_path(order)
    expect(page).to have_content 'Finalize o pedido'
    expect(page).to have_content 'Cliente: Joãozinho'
    expect(page).to have_content 'E-mail: cliente@gmail.com'
    expect(page).to have_content 'Telefone: 81987654321'
    expect(page).to have_content 'CPF: 61354764080'
    expect(page).to have_content 'Batata pequena'
    expect(page).to have_content 'colocar ketchup'
    expect(page).to have_content 'R$ 10,00'
    expect(page).to have_button 'Finalizar pedido'

  end

  it 'and should create a new order successfully and confirm it' do 
    user = User.create!(email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
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

    login_as(user)
    visit new_restaurant_menu_order_path(restaurant, menu)
    select 'Joãozinho', from: 'Cliente'
    select 'Batata pequena - R$ 10.00', from: 'Item'
    fill_in 'Observação', with: 'colocar ketchup'
    click_on 'Registrar pedido'
    click_on 'Finalizar pedido'

    expect(page).to have_content 'Pedido confirmado'
  end

  it 'and should display an error message when customer hasnt selected' do 
    user = User.create!(email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
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

    login_as(user)
    visit new_restaurant_menu_order_path(restaurant, menu)
    select 'Batata pequena - R$ 10.00', from: 'Item'
    fill_in 'Observação', with: 'colocar ketchup'
    click_on 'Registrar pedido'

    expect(page).to have_content 'Erro ao cadastrar pedido: Cliente é obrigatório(a)'
  end

  it 'and should display an error message when order item hasnt selected' do 
    user = User.create!(email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
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

    login_as(user)
    visit new_restaurant_menu_order_path(restaurant, menu)
    select 'Joãozinho', from: 'Cliente'
    click_on 'Registrar pedido'

    expect(page).to have_content 'Erro ao cadastrar pedido: Item do pedido deve conter pelo menos um item.'
  end
end