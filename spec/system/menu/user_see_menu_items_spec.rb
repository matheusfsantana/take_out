require 'rails_helper'

describe 'User see menu items' do
  it 'and should see only the active items' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
    first_beverage = Beverage.create!(name: 'Refrigerante lata', description: 'teste', calories: 300, alcoholic: false, restaurant: restaurant)
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

    expect(current_path).to eq menu_path(menu)
    expect(page).to have_content 'Pratos'
    expect(page).to have_content('Batata frita')
    expect(page).to have_content('Batata pequena')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Batata grande')
    expect(page).to have_content('R$ 15,00')
    expect(page).to have_content 'Bebidas'
    expect(page).to have_content('Refrigerante lata')
    expect(page).to have_content('Coca-cola 500ml')
    expect(page).to have_content('R$ 6,00')
    expect(page).to have_content('Fanta 500ml')
    expect(page).to have_content('R$ 5,00')

  end
  it 'and shouldnt see inactive items' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
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

    expect(current_path).to eq menu_path(menu)
    expect(page).to have_content('Batata frita')
    expect(page).to have_content('Batata pequena')
    expect(page).to have_content('R$ 10,00')
    expect(page).to have_content('Batata grande')
    expect(page).to have_content('R$ 15,00')
    expect(page).not_to have_content('Refrigerante lata')
    expect(page).not_to have_content('Coca-cola 500ml')
    expect(page).not_to have_content('R$ 6,00')
    expect(page).not_to have_content('Fanta 500ml')
    expect(page).not_to have_content('R$ 5,00')
  end

  it 'and shouldnt see inactive items' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
    Beverage.create!(is_active: false, name: 'Refrigerante lata', description: 'teste', calories: 300, alcoholic: false, restaurant: restaurant)
    Menu.create!(name: 'Lanches', restaurant: restaurant)


    login_as(user)
    visit root_path
    click_on 'Lanches'

    expect(page).to have_content('Nenhum item cadastrado para esse cardápio.')
  end
end