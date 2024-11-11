require 'rails_helper'

describe 'User visit dish index page' do
  it 'and should redirect to root_path if isnt your restaurant' do
    first_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    first_user = User.create!(restaurant: first_restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)

    second_user_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lanches.com', phone_number: '81987654321')
    User.create!(restaurant: second_user_restaurant, email: 'abcd@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)


    login_as(first_user)
    visit restaurant_beverages_path(second_user_restaurant)
    
    expect(current_path).to eq root_path
  end
  it "and should see 'Cadastrar nova bebida' button" do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    
    expect(page).to have_link "Cadastrar nova bebida", href: new_restaurant_beverage_path(restaurant)
  end
  it "and should see beverages with link_to dish details page'" do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    
    expect(page).to have_link "Suco de laranja", href: restaurant_beverage_path(restaurant, beverage)
    expect(current_path).to eq restaurant_beverages_path(restaurant)
  end
  it "and should see 'Nenhuma bebida cadastrada.' if no beverages are registered" do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    
    expect(page).to have_content "Nenhuma bebida cadastrada."
  end
end