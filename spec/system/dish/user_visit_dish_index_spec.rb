require 'rails_helper'

describe 'User visit dish index page' do
  it 'and should redirect to root_path if isnt your restaurant' do
    first_user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: first_user)

    second_user = User.create!(email: 'abcd@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    second_user_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lanches.com', phone_number: '81987654321', user: second_user)


    login_as(first_user)
    visit restaurant_dishes_path(second_user_restaurant)
    
    expect(current_path).to eq root_path
  end
  it 'and should see dishes with link_to dish details page' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
    dish = Dish.create!(name: 'teste', description: 'testando', calories: 10, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Pratos'
    
    expect(page).to have_link "teste", href: restaurant_dish_path(restaurant, dish)
    expect(current_path).to eq restaurant_dishes_path(restaurant)
  end
  it "and should see 'Cadastrar novo prato' button" do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)

    login_as(user)
    visit root_path
    click_on 'Pratos'
    
    expect(page).to have_link "Cadastrar novo prato", href: new_restaurant_dish_path(restaurant)
  end
  it "and should display 'Nenhum prato cadastrado' if no dishes are registered" do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)

    login_as(user)
    visit root_path
    click_on 'Pratos'
    
    expect(page).to have_content "Nenhum prato cadastrado."
  end
end