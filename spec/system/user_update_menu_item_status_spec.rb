require 'rails_helper'

describe 'User update menu item status to active or inactive' do
  context 'Update Dish' do
    it 'and should see the active button when access dish details page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
  
      expect(page).to have_button 'Ativar'
    end
    it 'and should see the desactive button when access dish details page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: true, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
  
      expect(page).to have_button 'Desativar'
    end
    it 'and should active a dish successfully' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
      click_on 'Ativar'
  
      expect(page).to have_content 'Status atualizado com sucesso para: Ativo'
    end
    it 'and should desactive a dish successfully' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: true, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
      click_on 'Desativar'
  
      expect(page).to have_content 'Status atualizado com sucesso para: Inativo'
    end
  end

  context 'Update Beverage' do
    it 'and should see the active button when access beverage details page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300,
                       alcoholic: true, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Cerveja'
  
      expect(page).to have_button 'Ativar'
    end
    it 'and should see the desactive button when access beverage details page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300,
                       alcoholic: true, is_active: true, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Cerveja'
  
      expect(page).to have_button 'Desativar'
    end
   
    it 'and should active a beverage successfully' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300,
                       alcoholic: true, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Cerveja'
      click_on 'Ativar'
  
      expect(page).to have_content 'Status atualizado com sucesso para: Ativo'
    end
    it 'and should desactive a beverage successfully' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300,
                       alcoholic: true, is_active: true, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Cerveja'
      click_on 'Desativar'
  
      expect(page).to have_content 'Status atualizado com sucesso para: Inativo'
    end
  end

  context 'See Dish Status' do
    it 'and should see the active status when access dish index page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: true, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
  
      expect(page).to have_content 'Ativo'
    end
    it 'and should see the inactive status when access dish index page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
  
      expect(page).to have_content 'Inativo'
    end
    it 'and should see the active status when access dish details page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: true, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
  
      expect(page).to have_content 'Ativo'
    end
    it 'and should see the inactive status when access dish details page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
  
      expect(page).to have_content 'Inativo'
    end
  end

  context 'See Beverage Status' do 
    it 'and should see the active status when access beverage index page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300,
                       alcoholic: true, is_active: true, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
  
      expect(page).to have_content 'Ativo'
    end
    it 'and should see the inactive status when access beverage index page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300,
                       alcoholic: true, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
  
      expect(page).to have_content 'Inativo'
    end
    it 'and should see the active status when access beverage details page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300,
                       alcoholic: true, is_active: true, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Cerveja'
  
      expect(page).to have_content 'Ativo'
    end
    it 'and should see the inactive status when access beverage details page' do
      user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300,
                       alcoholic: true, is_active: false, restaurant: restaurant)
  
      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Cerveja'
  
      expect(page).to have_content 'Inativo'
    end
  end
end