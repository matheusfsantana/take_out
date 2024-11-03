require 'rails_helper'

describe 'User can see menu item option historical after updates an option' do
  it 'and should successfully see the historical when updates an dish option' do 
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
    dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
    option = MenuItemOption.create!(description: 'Individual', price: 30, menu_item: dish)

    option.update!(price: 45)

    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'Bife a cavalo'
    click_on 'Ver histórico de porções'

    expect(page).to have_content 'Individual'
    expect(page).to have_content '30,00'
  end

  it 'and should display a message when historical is empty' do 
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
    dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
    MenuItemOption.create!(description: 'Individual', price: 30, menu_item: dish)

    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'Bife a cavalo'
    click_on 'Ver histórico de porções'

    expect(page).to have_content 'Nenhuma histórico registrado para Bife a cavalo'
  end

  it 'and should successfully see the historical when updates an beverage option' do 
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
    beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)
    option = MenuItemOption.create!(description: 'Jarra 1L', price: 19, menu_item: beverage)

    option.update!(price: 21)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Suco de laranja'
    click_on 'Ver histórico de porções'

    expect(page).to have_content 'Jarra 1L'
    expect(page).to have_content '19,00'
  end

  it 'and should display a message when historical is empty' do 
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
    beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)
    MenuItemOption.create!(description: 'Jarra 1L', price: 19, menu_item: beverage)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Suco de laranja'
    click_on 'Ver histórico de porções'

    expect(page).to have_content 'Nenhuma histórico registrado para Suco de laranja'
  end
end