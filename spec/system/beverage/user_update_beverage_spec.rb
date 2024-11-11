require 'rails_helper'

describe 'User update beverage' do
  it 'and should see the edit button' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    beverage = Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300, alcoholic: true, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Cerveja'

    expect(page).to have_link 'Editar Bebida', href: edit_restaurant_beverage_path(restaurant, beverage)
  end
  it 'and should see all fields' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Suco de laranja'
    click_on 'Editar Bebida'

    expect(page).to have_field 'Nome', with: 'Suco de laranja'
    expect(page).to have_field 'Descrição', with: 'Suco feito da polpa'
    expect(page).to have_field 'Calorias', with: 100
    expect(page).to have_field 'Imagem'
  end
  it 'and should edit with success' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Suco de laranja'
    click_on 'Editar Bebida'

    fill_in 'Nome', with: 'Suco de laranja com limão'
    fill_in 'Descrição', with: 'Suco feito da polpa de laranja e de limão'
    fill_in 'Calorias', with: 250
    attach_file "Imagem", Rails.root.join("spec/fixtures/files/test_image.png")
    click_on 'Atualizar bebida'

    expect(current_path).to eq restaurant_beverage_path(restaurant, beverage)
    expect(page).to have_content 'Bebida atualizada com sucesso.'
    expect(page).to have_content 'Suco de laranja com limão'
    expect(page).to have_content 'Suco feito da polpa de laranja e de limão'
    expect(page).to have_content '250'
    expect(Beverage.find(1).image).to be_attached

  end
  it 'and should fail when mandatory fields are empty' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Suco de laranja'
    click_on 'Editar Bebida'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Atualizar bebida'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end
  it 'and should fail when calories field is negative' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)


    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Suco de laranja'
    click_on 'Editar Bebida'

    fill_in 'Nome', with: 'Cerveja'
    fill_in 'Descrição', with: 'Cerveja artesanal da casa'
    fill_in 'Calorias', with: -1
    click_on 'Atualizar bebida'

    expect(page).to have_content 'Calorias não pode ser negativa'
  end
  it 'and should fail when file extension different of jpeg or png' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)


    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Suco de laranja'
    click_on 'Editar Bebida'

    fill_in 'Nome', with: 'Cerveja'
    fill_in 'Descrição', with: 'Cerveja artesanal da casa'
    fill_in 'Calorias', with: 1
    attach_file "Imagem", Rails.root.join("spec/fixtures/files/teste.txt")
    click_on 'Atualizar bebida'

    expect(page).to have_content 'Imagem deve ser JPEG ou PNG'
  end
end