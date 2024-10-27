require 'rails_helper'

describe 'User update dish' do
  it 'and should see the edit button' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
    dish = Dish.create!(name: 'teste', description: 'testando', calories: 10, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'teste'

    expect(page).to have_link 'Editar Prato', href: edit_restaurant_dish_path(restaurant, dish)
  end
  it 'and should see all fields' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
    Dish.create!(name: 'teste', description: 'testando', calories: 10, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'teste'
    click_on 'Editar Prato'

    expect(page).to have_field 'Nome', with: 'teste'
    expect(page).to have_field 'Descrição', with: 'testando'
    expect(page).to have_field 'Calorias', with: 10
    expect(page).to have_field 'Imagem'
  end
  it 'with success' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
    dish = Dish.create!(name: 'teste', description: 'testando', calories: 10, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'teste'
    click_on 'Editar Prato'

    fill_in 'Nome', with: 'Feijoada'
    fill_in 'Descrição', with: 'Feijoada da Dona Maria'
    fill_in 'Calorias', with: 1500
    attach_file "Imagem", Rails.root.join("spec/fixtures/files/test_image.png")
    click_on 'Atualizar prato'

    expect(current_path).to eq restaurant_dish_path(restaurant, dish)
    expect(page).to have_content 'Prato atualizado com sucesso.'
    expect(page).to have_content 'Feijoada'
    expect(page).to have_content 'Feijoada da Dona Maria'
    expect(page).to have_content '1500'
    expect(Dish.find(1).image).to be_attached

  end
  it 'with mandatory fields empty' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
    Dish.create!(name: 'teste', description: 'testando', calories: 10, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'teste'
    click_on 'Editar Prato'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Atualizar prato'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end
  it 'with calories field negative' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
    Dish.create!(name: 'teste', description: 'testando', calories: 10, restaurant: restaurant)


    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'teste'
    click_on 'Editar Prato'

    fill_in 'Nome', with: 'Feijoada'
    fill_in 'Descrição', with: 'Feijão preto, Carne seca, Costelinha, Linguiça calabresa, Bacon, Paio, Lombo salgado, Pernil salgado, Rabo, Pé'
    fill_in 'Calorias', with: -1
    click_on 'Atualizar prato'

    expect(page).to have_content 'Calorias não pode ser negativa'
  end
  it 'with file extension different of jpeg or png' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
    Dish.create!(name: 'teste', description: 'testando', calories: 10, restaurant: restaurant)


    login_as(user)
    visit root_path
    click_on 'Pratos'
    click_on 'teste'
    click_on 'Editar Prato'

    fill_in 'Nome', with: 'Feijoada'
    fill_in 'Descrição', with: 'Feijão preto, Carne seca, Costelinha, Linguiça calabresa, Bacon, Paio, Lombo salgado, Pernil salgado, Rabo, Pé'
    fill_in 'Calorias', with: 1
    attach_file "Imagem", Rails.root.join("spec/fixtures/files/teste.txt")
    click_on 'Atualizar prato'

    expect(page).to have_content 'Imagem deve ser JPEG ou PNG'
  end
end