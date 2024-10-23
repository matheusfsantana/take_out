require 'rails_helper'

describe 'User sign up' do
  it 'with success' do
    visit root_path
    click_on 'Crie sua conta'
    fill_in 'Nome', with: 'Joãozinho'
    fill_in 'Sobrenome', with: 'Da Silva'
    fill_in 'CPF', with: '81956904085'
    fill_in 'E-mail', with: "joaozinho@gmail.com"
    fill_in 'Senha', with: '123456789abcd'
    fill_in 'Confirme sua senha', with: '123456789abcd'
    click_on 'Cadastrar'

    expect(page).to have_content 'Joãozinho'
    expect(page).to have_content 'Sair'
    expect(page).to have_content 'Conta criada com sucesso.'
    expect(current_path).to eq root_path

  end
  it "and don't fill all fields" do
    visit root_path
    click_on 'Crie sua conta'
    fill_in 'Nome', with: ''
    fill_in 'Sobrenome', with: ''
    fill_in 'CPF', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirme sua senha', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Sobrenome não pode ficar em branco'
    expect(page).to have_content 'CPF não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Senha não pode ficar em branco'
  end
end