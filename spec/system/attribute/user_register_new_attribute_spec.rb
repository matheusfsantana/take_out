require 'rails_helper'

describe 'User register a new attribute' do
  it "and unauthenticated users shouldn't access to the create attribute form" do
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)

    visit new_restaurant_attribute_path(restaurant)

    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    expect(current_path).to eq new_user_session_path
  end
  
  it 'and should access the attribute form' do
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)

    login_as(user)

    visit root_path
    click_on 'Marcadores'
    click_on 'Cadastrar novo marcador'

    expect(page).to have_field 'Marcador'
    expect(current_path).to eq new_restaurant_attribute_path(restaurant)
  end

  it 'and should register successfully' do
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
                      
    login_as(user)

    visit root_path
    click_on 'Marcadores'
    click_on 'Cadastrar novo marcador'
    fill_in 'Marcador', with: 'Apimentado'
    click_on 'Cadastrar marcador'

    expect(page).to have_content 'Marcador cadastrado com sucesso'
    expect(page).to have_content 'Apimentado'
    expect(current_path).to eq restaurant_attributes_path(restaurant)
  end

  it 'and should display an error message when name field is empty' do
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
                      
    login_as(user)

    visit root_path
    click_on 'Marcadores'
    click_on 'Cadastrar novo marcador'
    fill_in 'Marcador', with: ''
    click_on 'Cadastrar marcador'

    expect(page).to have_content 'Erro ao cadastrar marcador'
    expect(page).to have_content 'Marcador não pode ficar em branco'
    expect(current_path).to eq restaurant_attributes_path(restaurant)
  end

  it 'and should display an error message when name field is empty' do
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
                      
    login_as(user)

    visit root_path
    click_on 'Marcadores'
    click_on 'Cadastrar novo marcador'
    fill_in 'Marcador', with: ''
    click_on 'Cadastrar marcador'

    expect(page).to have_content 'Erro ao cadastrar marcador'
    expect(page).to have_content 'Marcador não pode ficar em branco'
    expect(current_path).to eq restaurant_attributes_path(restaurant)
  end
end