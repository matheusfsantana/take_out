require 'rails_helper'

describe 'User visit dish details page' do
  it 'and should redirect to root_path if dish doesnt exist' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)


    login_as(user)
    visit restaurant_dish_path(restaurant, 1)

    expect(current_path).to eq root_path
  end
  it 'and should see dish details' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
    dish = Dish.create!(name: 'teste', description: 'testando', calories: 10, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'teste'
    
    expect(current_path).to eq restaurant_dish_path(restaurant, dish)
    expect(page).to have_content 'teste'
    expect(page).to have_content 'testando'
    expect(page).to have_content '10'
  end
end