require 'rails_helper'

describe 'User visit dish details page' do
  it 'and should redirect to root_path if dish doesnt exist' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)


    login_as(user)
    visit restaurant_dish_path(restaurant, 1)

    expect(current_path).to eq root_path
  end
  it 'and should see dish details' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    dish = Dish.create!(name: 'teste', description: 'testando', calories: 10, restaurant: restaurant)
    tag_1 = Tag.create!(name: 'Apimentado', restaurant: restaurant)
    tag_2 = Tag.create!(name: 'Vegano', restaurant: restaurant)
    ItemTag.create!(item: dish, tag: tag_1)
    ItemTag.create!(item: dish, tag: tag_2)

    
    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'teste'
    
    expect(current_path).to eq restaurant_dish_path(restaurant, dish)
    expect(page).to have_content 'teste'
    expect(page).to have_content 'testando'
    expect(page).to have_content '10'
    expect(page).to have_content 'Apimentado'
    expect(page).to have_content 'Vegano'
  end
end