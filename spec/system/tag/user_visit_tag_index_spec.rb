require 'rails_helper'

describe 'User visit tag index page' do
  it "and unauthenticated users shouldn't access the page" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    Tag.create!(name: 'Apimentado', restaurant: restaurant)  
    
    visit restaurant_tags_path(restaurant)

    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(current_path).to eq new_user_session_path
  end

  it "and should see the tags registered when user is authenticated" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    Tag.create!(name: 'Apimentado', restaurant: restaurant) 
    Tag.create!(name: 'Sem glúten', restaurant: restaurant)   

    login_as(user)
    visit root_path
    click_on 'Marcadores'

    expect(page).to have_content 'Apimentado'
    expect(page).to have_content 'Sem glúten'
    expect(current_path).to eq restaurant_tags_path(restaurant)
  end

  it "and shouldn't see the tag of others restaurants" do
    first_restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    User.create!(restaurant: first_restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    Tag.create!(name: 'Apimentado', restaurant: first_restaurant) 
    Tag.create!(name: 'Sem glúten', restaurant: first_restaurant)   
    
    second_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lanches.com', phone_number: '81987654321')
    second_user = User.create!(restaurant: second_restaurant, email: 'abcd@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    
    login_as(second_user)
    visit root_path
    click_on 'Marcadores'

    expect(page).not_to have_content 'Apimentado'
    expect(page).not_to have_content 'Sem glúten'
  end

  it "and should see a message when no tags are registered" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')

    
    login_as(user)
    visit root_path
    click_on 'Marcadores'

    expect(page).to have_content 'Nenhuma marcador cadastrado.'
  end
end