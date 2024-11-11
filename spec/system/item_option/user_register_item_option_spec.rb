require 'rails_helper'

describe 'User register a item item option from menu item details page' do
  context 'register dish options' do
    it 'and should see the register option button on dish details page' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
  
      expect(page).to have_link 'Cadastrar porção'
    end

    it 'and should see the fields' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
      click_on 'Cadastrar porção'

      expect(current_path).to eq new_item_option_path(dish)
      expect(page).to have_content 'Bife a cavalo'
      expect(page).to have_field 'Descrição da porção'
      expect(page).to have_field 'Preço'
    end
    it 'and should register a option successfully' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
      click_on 'Cadastrar porção'
      fill_in 'Descrição da porção', with: 'Individual'
      fill_in 'Preço', with: '30,00'
      click_on 'Cadastrar porção'

      expect(current_path).to eq dish_path(dish)
      expect(page).to have_content 'Porção cadastrada com sucesso.'
      expect(page).to have_content 'Individual'
      expect(page).to have_content 'R$ 30,00'
    end
    it 'and should display error messages when required fields are left blank' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
      click_on 'Cadastrar porção'
      fill_in 'Descrição da porção', with: ''
      fill_in 'Preço', with: ''
      click_on 'Cadastrar porção'

      expect(page).to have_content 'Ocorreu um erro ao cadastrar porção'
      expect(page).to have_content 'Descrição da porção não pode ficar em branco'
      expect(page).to have_content 'Preço não pode ficar em branco'
    end
    it 'and should display error messages when price field is negative' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
      click_on 'Cadastrar porção'
      fill_in 'Descrição da porção', with: 'Teste'
      fill_in 'Preço', with: '-1'
      click_on 'Cadastrar porção'
      
      expect(page).to have_content 'Ocorreu um erro ao cadastrar porção'
      expect(page).to have_content 'Preço deve ser maior que 0'
    end
  end

  context 'register beverage options' do
    it 'and should see the register option button on beverage details page' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Suco de laranja'
  
      expect(page).to have_link 'Cadastrar porção'
    end

    it 'and should see the fields' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Suco de laranja'
      click_on 'Cadastrar porção'

      expect(current_path).to eq new_item_option_path(beverage)
      expect(page).to have_content 'Suco de laranja'
      expect(page).to have_field 'Descrição da porção'
      expect(page).to have_field 'Preço'
    end
    it 'and should register a option successfully' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Suco de laranja'
      click_on 'Cadastrar porção'
      fill_in 'Descrição da porção', with: 'Jarra de 1L'
      fill_in 'Preço', with: '19,00'
      click_on 'Cadastrar porção'

      expect(current_path).to eq beverage_path(beverage)
      expect(page).to have_content 'Porção cadastrada com sucesso.'
      expect(page).to have_content 'Jarra de 1L'
      expect(page).to have_content 'R$ 19,00'
    end
    it 'and should display error messages when required fields are left blank' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Suco de laranja'
      click_on 'Cadastrar porção'
      fill_in 'Descrição da porção', with: ''
      fill_in 'Preço', with: ''
      click_on 'Cadastrar porção'

      expect(page).to have_content 'Ocorreu um erro ao cadastrar porção'
      expect(page).to have_content 'Descrição da porção não pode ficar em branco'
      expect(page).to have_content 'Preço não pode ficar em branco'
    end
    it 'and should display error messages when price field is negative' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Suco de laranja'
      click_on 'Cadastrar porção'
      fill_in 'Descrição da porção', with: 'Teste'
      fill_in 'Preço', with: '-1'
      click_on 'Cadastrar porção'
      
      expect(page).to have_content 'Ocorreu um erro ao cadastrar porção'
      expect(page).to have_content 'Preço deve ser maior que 0'
    end
  end
end