require 'rails_helper'

describe 'User register a menu to restaurant' do
  it 'and should see the fields' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Dish.create!(name: 'Pão com queijo', description: 'testando', calories: 10, restaurant: restaurant)
    Dish.create!(name: 'Pão com ovo', description: 'testando', calories: 10, restaurant: restaurant)
    Beverage.create!(name: 'Café', description: 'teste', calories: 300, alcoholic: true, restaurant: restaurant)
    Beverage.create!(name: 'Água', description: 'teste', calories: 300, alcoholic: true, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Cadastrar novo cardápio'

    expect(current_path).to eq new_restaurant_menu_path(restaurant)
    
    expect(page).to have_field 'Nome'
    expect(page).to have_content 'Pratos'
    expect(page).to have_unchecked_field('Pão com queijo')
    expect(page).to have_unchecked_field('Pão com ovo')
    expect(page).to have_content 'Bebidas'
    expect(page).to have_unchecked_field('Café')
    expect(page).to have_unchecked_field('Água')
  end

  it 'and should see a message when no dishes and no beverages are registered' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)

    login_as(user)
    visit root_path
    click_on 'Cadastrar novo cardápio'


    expect(page).to have_field 'Nome'
    expect(page).to have_content 'Pratos'
    expect(page).to have_content 'Nenhum prato cadastrado.'
    expect(page).to have_content 'Bebidas'
    expect(page).to have_content 'Nenhuma bebida cadastrada.'
  end

  it 'and should register a new menu successfully' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Dish.create!(name: 'Pão com queijo', description: 'testando', calories: 10, restaurant: restaurant)
    selected_dish = Dish.create!(name: 'Pão com ovo', description: 'testando', calories: 10, restaurant: restaurant)
    selected_beverage = Beverage.create!(name: 'Café', description: 'teste', calories: 300, alcoholic: true, restaurant: restaurant)
    Beverage.create!(name: 'Água', description: 'teste', calories: 300, alcoholic: true, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Cadastrar novo cardápio'
    fill_in 'Nome', with: 'Café da manhã'
    check 'Pão com ovo'
    check 'Café'
    click_on 'Cadastrar cardápio'

    expect(page).to have_content 'Cardápio cadastrado com sucesso'
    expect(current_path).to eq root_path
    expect(Menu.find(1).name).to eq 'Café da manhã'
    expect(MenuItem.find_by(item: selected_dish)).not_to be_nil
    expect(MenuItem.find_by(item: selected_beverage)).not_to be_nil
  end

  it 'and should see a error message when name field is empty' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Dish.create!(name: 'Pão com queijo', description: 'testando', calories: 10, restaurant: restaurant)
    Dish.create!(name: 'Pão com ovo', description: 'testando', calories: 10, restaurant: restaurant)
    Beverage.create!(name: 'Café', description: 'teste', calories: 300, alcoholic: true, restaurant: restaurant)
    Beverage.create!(name: 'Água', description: 'teste', calories: 300, alcoholic: true, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Cadastrar novo cardápio'
    fill_in 'Nome', with: ''
    check 'Pão com ovo'
    check 'Café'
    click_on 'Cadastrar cardápio'

    expect(page).to have_content 'Erro ao cadastrar cardápio'
    expect(page).to  have_content 'Nome não pode ficar em branco'
  end

  it 'and should see a error message when name already exists for your restaurant' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Menu.create!(name: 'Café da manhã', restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Cadastrar novo cardápio'
    fill_in 'Nome', with: 'Café da manhã'
    click_on 'Cadastrar cardápio'

    expect(page).to have_content 'Erro ao cadastrar cardápio'
    expect(page).to  have_content 'já existente para seu restaurante'
  end
end