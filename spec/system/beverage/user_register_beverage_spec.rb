require 'rails_helper'

describe 'User register beverage' do
  it 'and should see all fields' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar nova bebida'

    expect(current_path).to eq new_beverage_path
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Calorias'
    expect(page).to have_field 'Imagem'
    expect(page).to have_field 'Alcoólico'
  end
  it 'and should create with success' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar nova bebida'

    fill_in 'Nome', with: 'Cerveja'
    fill_in 'Descrição', with: 'Cerveja artesanal da casa'
    fill_in 'Calorias', with: 300
    check  'Alcoólico'
    attach_file "Imagem", Rails.root.join("spec/fixtures/files/test_image.png")
    click_on 'Cadastrar bebida'

    expect(page).to have_content 'Nova bebida cadastrada com sucesso.'
    expect(current_path).to eq beverages_path
    expect(Beverage.find(1).image).to be_attached
  end
  it 'and should fail when mandatory fields are empty' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)


    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar nova bebida'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Cadastrar bebida'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end
  it 'and should fail when calories field is negative' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)


    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar nova bebida'

    fill_in 'Nome', with: 'Cerveja'
    fill_in 'Descrição', with: 'Cerveja artesanal da casa'
    fill_in 'Calorias', with: -1
    click_on 'Cadastrar bebida'

    expect(page).to have_content 'Calorias não pode ser negativa'
  end
  it 'and should fail when file extension different of jpeg or png' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)


    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Cadastrar nova bebida'

    fill_in 'Nome', with: 'Cerveja'
    fill_in 'Descrição', with: 'Cerveja artesanal da casa'
    fill_in 'Calorias', with: 1
    attach_file "Imagem", Rails.root.join("spec/fixtures/files/teste.txt")
    click_on 'Cadastrar bebida'

    expect(page).to have_content 'Imagem deve ser JPEG ou PNG'
  end
end