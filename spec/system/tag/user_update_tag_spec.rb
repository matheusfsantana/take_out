require 'rails_helper'

describe 'User update an tag' do
  it "and unauthenticated users shouldn't access to the tag form" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')

    tag = Tag.create!(name: 'Apimentado', restaurant: restaurant)  

    visit edit_restaurant_tag_path(restaurant, tag)

    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(current_path).to eq new_user_session_path
  end

  it "and users who do not belong to this restaurant shouldn't access the edit form " do
    first_restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                         full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    User.create!(restaurant: first_restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
                      
    second_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                       full_address:'Rua da Hot, 721 - RJ',email:'contato@lanches.com', phone_number: '81987654321')
    second_user = User.create!(restaurant: second_restaurant, email: 'abcd@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    
    tag = Tag.create!(name: 'Apimentado', restaurant: first_restaurant)  
   
    login_as(second_user)
    visit edit_restaurant_tag_path(first_restaurant, tag)

    expect(current_path).to eq root_path
  end

  it 'and should access the edit form with field filled' do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    tag = Tag.create!(name: 'Apimentado', restaurant: restaurant)  

    login_as(user)
    visit root_path
    click_on 'Marcadores'
    click_on 'Editar'

    expect(page).to have_field 'Marcador', with: 'Apimentado'
    expect(current_path).to eq edit_restaurant_tag_path(restaurant, tag)
  end

  it 'and should update successfully' do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')           
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    tag = Tag.create!(name: 'Apimentado', restaurant: restaurant)  

    login_as(user)
    visit edit_restaurant_tag_path(restaurant, tag)
    fill_in 'Marcador', with: 'Picante'
    click_on 'Atualizar marcador'


    expect(page).to have_content 'Marcador atualizado com sucesso'
    expect(page).to have_content 'Picante'
    expect(page).not_to have_content 'Apimentado'
    expect(current_path).to eq restaurant_tags_path(restaurant)
  end

  it 'and should display an error message when name field is empty' do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    tag = Tag.create!(name: 'Apimentado', restaurant: restaurant)  

    login_as(user)
    visit edit_restaurant_tag_path(restaurant, tag)
    fill_in 'Marcador', with: ''
    click_on 'Atualizar marcador'

    expect(page).to have_content 'Erro ao atualizar marcador'
    expect(page).to have_content 'Marcador não pode ficar em branco'
  end
end