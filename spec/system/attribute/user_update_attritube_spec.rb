require 'rails_helper'

describe 'User update an attribute' do
  it "and unauthenticated users shouldn't access to the attribute form" do
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)

    attribute = Attribute.create!(name: 'Apimentado', restaurant: restaurant)  

    visit edit_restaurant_attribute_path(restaurant, attribute)

    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(current_path).to eq new_user_session_path
  end

  it "and users who do not belong to this restaurant shouldn't access the edit form " do
    first_user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    first_restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: first_user)
                      
    second_user = User.create!(email: 'abcd@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                       full_address:'Rua da Hot, 721 - RJ',email:'contato@lanches.com', phone_number: '81987654321', user: second_user)
    
    attribute = Attribute.create!(name: 'Apimentado', restaurant: first_restaurant)  
   
    login_as(second_user)
    visit edit_restaurant_attribute_path(first_restaurant, attribute)

    expect(current_path).to eq root_path
  end

  it 'and should access the edit form with field filled' do
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
    attribute = Attribute.create!(name: 'Apimentado', restaurant: restaurant)  

    login_as(user)
    visit root_path
    click_on 'Marcadores'
    click_on 'Editar'

    expect(page).to have_field 'Marcador', with: 'Apimentado'
    expect(current_path).to eq edit_restaurant_attribute_path(restaurant, attribute)
  end

  it 'and should update successfully' do
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)           
    attribute = Attribute.create!(name: 'Apimentado', restaurant: restaurant)  

    login_as(user)
    visit edit_restaurant_attribute_path(restaurant, attribute)
    fill_in 'Marcador', with: 'Picante'
    click_on 'Atualizar marcador'


    expect(page).to have_content 'Marcador atualizado com sucesso'
    expect(page).to have_content 'Picante'
    expect(page).not_to have_content 'Apimentado'
    expect(current_path).to eq restaurant_attributes_path(restaurant)
  end

  it 'and should display an error message when name field is empty' do
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
    attribute = Attribute.create!(name: 'Apimentado', restaurant: restaurant)  

    login_as(user)
    visit edit_restaurant_attribute_path(restaurant, attribute)
    fill_in 'Marcador', with: ''
    click_on 'Atualizar marcador'

    expect(page).to have_content 'Erro ao atualizar marcador'
    expect(page).to have_content 'Marcador não pode ficar em branco'
  end
end