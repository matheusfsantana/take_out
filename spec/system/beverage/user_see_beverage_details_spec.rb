require 'rails_helper'

describe 'User visit beverage details page' do
  it 'and should redirect to root_path if beverage doesnt exist' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)


    login_as(user)
    visit restaurant_beverage_path(restaurant, 1)

    expect(current_path).to eq root_path
  end
  it 'and should see beverage details' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    beverage = Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300, alcoholic: true, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Cerveja'
    
    expect(current_path).to eq restaurant_beverage_path(restaurant, beverage)
    expect(page).to have_content 'Cerveja'
    expect(page).to have_content 'Cerveja artesanal da casa'
    expect(page).to have_content '300'
    expect(page).to have_content 'Alcoólico'
  end
end