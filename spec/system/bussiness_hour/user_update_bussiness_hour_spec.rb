require 'rails_helper'

describe 'User register the bussiness hour of your restaurant' do
  it 'and see the fields' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                       full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao',
                 last_name: 'da Silva', cpf: CPF.generate, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Horário de Funcionamento'    

    expect(page).to have_content 'Segunda'
    expect(page).to have_content 'Terça'
    expect(page).to have_content 'Quarta'
    expect(page).to have_content 'Quinta'
    expect(page).to have_content 'Sexta'
    expect(page).to have_content 'Sábado'
    expect(page).to have_content 'Domingo'
  end

  it 'with success' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao',
                 last_name: 'da Silva', cpf: CPF.generate, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Horário de Funcionamento'
    within('table') do
      first('a', text: 'Editar').click
    end
    fill_in 'Horário de Abertura', with: '9:00'
    fill_in 'Horário de Fechamento', with: '20:00'
    check('Está aberto?')
    click_on 'Salvar Horário'

    expect(page).to have_content 'Horário atualizado com sucesso'
    expect(current_path).to eq bussiness_hours_path
    first_row = first('table tbody tr')
    expect(first_row).to have_content('Segunda')
    expect(first_row).to have_content('09:00')
    expect(first_row).to have_content('20:00')
    expect(first_row).to have_content('Sim')

  end
  it 'and the restaurant is not operating' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao',
                 last_name: 'da Silva', cpf: CPF.generate, restaurant: restaurant)

    login_as(user)
    visit root_path
    click_on 'Horário de Funcionamento'
    within('table') do
      first('a', text: 'Editar').click
    end
    uncheck('Está aberto?')
    click_on 'Salvar Horário'

    expect(page).to have_content 'Horário atualizado com sucesso'
    expect(current_path).to eq bussiness_hours_path
    first_row = first('table tbody tr')
    expect(first_row).to have_content('Segunda')
    expect(first_row).to have_content('Fechado')
    expect(first_row).to have_content('Não')
  end
end