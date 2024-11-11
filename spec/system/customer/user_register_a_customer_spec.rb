require 'rails_helper'

describe 'User register a customer' do
  it 'and should see all fields' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
    ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
    ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
    menu = Menu.create!(name: 'Lanches', restaurant: restaurant)
    MenuItem.create!(menu: menu, item: first_dish)

    login_as(user)
    visit root_path
    click_on 'Lanches'
    click_on 'Registrar pedido'
    click_on 'Cadastrar cliente'

    expect(current_path).to eq new_customer_path
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
  end

  it 'and should register successfully' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
    ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
    ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
    menu = Menu.create!(name: 'Lanches', restaurant: restaurant)
    MenuItem.create!(menu: menu, item: first_dish)

    login_as(user)
    visit root_path
    click_on 'Lanches'
    click_on 'Registrar pedido'
    click_on 'Cadastrar cliente'
    fill_in 'Nome', with: 'Fulano'
    fill_in 'E-mail', with: 'fulano@email.com'
    click_on 'Cadastrar cliente'

    expect(page).to have_content 'Cliente cadastrado com sucesso'
    expect(current_path).to eq new_menu_order_path(menu) # previous path
  end

  it 'and should display an error message when fields are empty' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
    ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
    ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
    menu = Menu.create!(name: 'Lanches', restaurant: restaurant)
    MenuItem.create!(menu: menu, item: first_dish)

    login_as(user)
    visit new_customer_path
    fill_in 'Nome', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Telefone', with: ''
    click_on 'Cadastrar cliente'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Telefone ou E-mail precisa estar presente'
  end

  it 'and should display an error message when phone_number and email are empty' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
    ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
    ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
    menu = Menu.create!(name: 'Lanches', restaurant: restaurant)
    MenuItem.create!(menu: menu, item: first_dish)

    login_as(user)
    visit new_customer_path
    fill_in 'Nome', with: 'Fulano'
    fill_in 'E-mail', with: ''
    fill_in 'Telefone', with: ''
    click_on 'Cadastrar cliente'

    expect(page).to have_content 'Telefone ou E-mail precisa estar presente'
  end

  it 'and should display an error message when cpf is present and is invalid' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
    ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
    ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
    menu = Menu.create!(name: 'Lanches', restaurant: restaurant)
    MenuItem.create!(menu: menu, item: first_dish)

    login_as(user)
    visit new_customer_path
    fill_in 'Nome', with: 'Fulano'
    fill_in 'E-mail', with: 'fulano@email.com'
    fill_in 'CPF', with: '123'
    click_on 'Cadastrar cliente'

    expect(page).to have_content 'CPF inválido'
  end
end
