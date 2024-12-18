require 'rails_helper'

describe 'User destroy beverage' do
  it 'and should see the destroy button' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Suco de laranja'

    expect(page).to have_button 'Excluir Bebida'
  end
  it 'and should delete with success' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Bebidas'
    click_on 'Suco de laranja'
    click_on 'Excluir Bebida'

    expect(Beverage.exists?(beverage.id)).to be_falsy
    expect(current_path).to eq beverages_path
    expect(page).to have_content 'Bebida excluída com sucesso'
  end

  it 'and shouldnt see the delete button if beverage has options registered' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)
    ItemOption.create!(description: 'Jarra 1L', price: 19, item: beverage)

    login_as(user)
    visit beverage_path(beverage)

    expect(page).not_to have_button 'Excluir Bebida'
  end
end