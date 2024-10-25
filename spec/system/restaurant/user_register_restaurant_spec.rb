require 'rails_helper'

describe 'User register your restaurant' do
  it 'when sign in see all fields' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)

    login_as(user)
    visit root_path

    expect(current_path).to eq new_restaurant_path
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
  end
  it 'when sign in and fill all fields' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)

    login_as(user)
    visit root_path

    fill_in 'Razão Social', with: 'Restaurante Bella Vista LTDA'
    fill_in 'Nome Fantasia', with: 'Restaurante Bella Vista'
    fill_in 'CNPJ', with: CNPJ.generate
    fill_in 'Endereço', with: 'Estrada de Aldeia, 900, Camaragibe - PE'
    fill_in 'Telefone', with: '81987654321'
    fill_in 'E-mail', with: 'restaurantebellavista@gmail.com'
    click_on 'Cadastrar'

    expect(page).to have_content 'Restaurante registrado com sucesso.'
    expect(current_path).to eq root_path
  end
  it "and don't fill all fields" do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)

    login_as(user)
    visit root_path

    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end
end