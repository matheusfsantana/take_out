require 'rails_helper'

describe 'Owner pre register a new employee' do
  it 'and should see all fields' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    login_as(user)
    visit root_path
    click_on 'Funcionários'
    click_on 'Pré-cadastrar funcionário'

    expect(current_path).to eq new_employee_path
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'CPF'
  end

  it 'and should pre register sucessfully' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    login_as(user)
    visit new_employee_path
    fill_in 'E-mail', with: 'teste@gmail.com'
    fill_in 'CPF', with: '99058921093'
    click_on 'Finalizar pré-cadastro'

    expect(page).to have_content 'teste@gmail.com'
    expect(page).to have_content '99058921093'
    expect(page).to have_content 'Não'
  end

  it 'and should display a message erro when email already in use' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    Employee.create!(email: 'teste@gmail.com', cpf: CPF.generate, restaurant: restaurant )
    login_as(user)
    visit new_employee_path
    fill_in 'E-mail', with: 'teste@gmail.com'
    fill_in 'CPF', with: '99058921093'
    click_on 'Finalizar pré-cadastro'

    expect(page).to have_content 'Erro ao realizar pré-cadastro'
    expect(page).to have_content 'E-mail já está em uso'
  end

  it 'and should display a message erro when cpf already in use' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
    Employee.create!(email: 'teste123@gmail.com', cpf: '99058921093', restaurant: restaurant )

    login_as(user)
    visit new_employee_path
    fill_in 'E-mail', with: 'teste@gmail.com'
    fill_in 'CPF', with: '99058921093'
    click_on 'Finalizar pré-cadastro'

    expect(page).to have_content 'Erro ao realizar pré-cadastro'
    expect(page).to have_content 'CPF já está em uso'
  end

  it 'and should display a message erro when email is invalid' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')

    login_as(user)
    visit new_employee_path
    fill_in 'E-mail', with: 'teste@email'
    fill_in 'CPF', with: '99058921093'
    click_on 'Finalizar pré-cadastro'

    expect(page).to have_content 'Erro ao realizar pré-cadastro'
    expect(page).to have_content 'E-mail inválido'
  end

  it 'and should display a message erro when cpf is invalid' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')

    login_as(user)
    visit new_employee_path
    fill_in 'E-mail', with: 'teste@gmail.com'
    fill_in 'CPF', with: '99058'
    click_on 'Finalizar pré-cadastro'

    expect(page).to have_content 'Erro ao realizar pré-cadastro'
    expect(page).to have_content 'CPF inválido'
  end
end