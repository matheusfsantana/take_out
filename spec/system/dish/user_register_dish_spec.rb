require 'rails_helper'

describe 'User register dish for your restaurant' do 
  it 'and see all fields' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)


    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar novo prato'

    expect(current_path).to eq new_restaurant_dish_path(restaurant)
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Calorias'
    expect(page).to have_field 'Imagem'
  end
  it 'with success' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)


    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar novo prato'

    fill_in 'Nome', with: 'Feijoada'
    fill_in 'Descrição', with: 'Feijão preto, Carne seca, Costelinha, Linguiça calabresa, Bacon, Paio, Lombo salgado, Pernil salgado, Rabo, Pé'
    fill_in 'Calorias', with: 1000
    attach_file "Imagem", Rails.root.join("spec/fixtures/files/test_image.png")
    click_on 'Cadastrar prato'

    expect(current_path).to eq restaurant_dishes_path(restaurant)
    expect(Dish.find(1).image).to be_attached
    expect(page).to have_content 'Novo prato cadastrado com sucesso.'
  end
  it 'with mandatory fields empty' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)


    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar novo prato'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Cadastrar prato'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end
  it 'with calories field negative' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)


    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar novo prato'

    fill_in 'Nome', with: 'Feijoada'
    fill_in 'Descrição', with: 'Feijão preto, Carne seca, Costelinha, Linguiça calabresa, Bacon, Paio, Lombo salgado, Pernil salgado, Rabo, Pé'
    fill_in 'Calorias', with: -1
    click_on 'Cadastrar prato'

    expect(page).to have_content 'Calorias não pode ser negativa'
  end
  it 'with file extension different of jpeg or png' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)


    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'Cadastrar novo prato'

    fill_in 'Nome', with: 'Feijoada'
    fill_in 'Descrição', with: 'Feijão preto, Carne seca, Costelinha, Linguiça calabresa, Bacon, Paio, Lombo salgado, Pernil salgado, Rabo, Pé'
    fill_in 'Calorias', with: 1
    attach_file "Imagem", Rails.root.join("spec/fixtures/files/teste.txt")
    click_on 'Cadastrar prato'

    expect(page).to have_content 'Imagem deve ser JPEG ou PNG'
  end
  
end