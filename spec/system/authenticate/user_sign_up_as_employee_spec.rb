require 'rails_helper'

describe 'User sign up as employee' do
  it 'with success and should update employee status' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao',
                 last_name: 'da Silva', cpf: CPF.generate, restaurant: restaurant)

    Employee.create!(email: 'teste@gmail.com', cpf: CPF.generate, restaurant: restaurant)

    visit root_path
    click_on 'Crie sua conta'
    fill_in 'Nome', with: 'Joãozinho'
    fill_in 'Sobrenome', with: 'Da Silva'
    fill_in 'CPF', with: '81956904085'
    fill_in 'E-mail', with: "teste@gmail.com"
    fill_in 'Senha', with: '123456789abcd'
    fill_in 'Confirme sua senha', with: '123456789abcd'
    click_on 'Cadastrar'
    employee = Employee.last

    expect(current_path).to eq root_path
    expect(page).to have_content 'Joãozinho'
    expect(page).to have_content 'Sair'
    expect(employee.is_registered).to be true
  end

  it 'with success and user should be in role employee' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao',
                 last_name: 'da Silva', cpf: CPF.generate, restaurant: restaurant)

    Employee.create!(email: 'teste@gmail.com', cpf: CPF.generate, restaurant: restaurant)

    visit root_path
    click_on 'Crie sua conta'
    fill_in 'Nome', with: 'Joãozinho'
    fill_in 'Sobrenome', with: 'Da Silva'
    fill_in 'CPF', with: '81956904085'
    fill_in 'E-mail', with: "teste@gmail.com"
    fill_in 'Senha', with: '123456789abcd'
    fill_in 'Confirme sua senha', with: '123456789abcd'
    click_on 'Cadastrar'
    new_user = User.last

    expect(current_path).to eq root_path
    expect(page).to have_content 'Joãozinho'
    expect(page).to have_content 'Sair'
    expect(new_user.restaurant).to eq restaurant
    expect(new_user.employee?).to be true
  end
end