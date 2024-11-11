require 'rails_helper'

describe 'User update a item option' do
  context 'update dish options' do
    it "and unauthenticated users shouldn't access to the edit form" do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
      option = ItemOption.create!(description: 'Individual', price: 30, item: dish)

      visit edit_restaurant_item_option_path(restaurant, dish, option)

      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
      expect(current_path).to eq new_user_session_path
    end

    it "and users who do not belong to this restaurant shouldn't access the edit form " do
      first_restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      User.create!(restaurant: first_restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: first_restaurant)
      option = ItemOption.create!(description: 'Individual', price: 30, item: dish)
     
                        
      second_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                         full_address:'Rua da Hot, 721 - RJ',email:'contato@lanches.com', phone_number: '81987654321')
      second_user = User.create!(restaurant: second_restaurant, email: 'abcd@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      
      login_as(second_user)
      visit edit_restaurant_item_option_path(first_restaurant, dish, option)

      expect(current_path).to eq root_path
    end

    it 'and when access the edit item_option form from dish details page should see all fields filled' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
      option = ItemOption.create!(description: 'Individual', price: 30, item: dish)

      login_as(user)
      visit root_path
      click_on 'Pratos'
      click_on 'Bife a cavalo'
      click_on 'Editar porção'

      expect(current_path).to eq edit_restaurant_item_option_path(restaurant, dish, option)
      expect(page).to have_field 'Descrição da porção', with: 'Individual'
      expect(page).to have_field 'Preço', with: "30.0"
    end

    it 'and should edit option successfully' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
      option = ItemOption.create!(description: 'Individual', price: 30, item: dish)

      login_as(user)
      visit edit_restaurant_item_option_path(restaurant, dish, option)
      fill_in 'Descrição da porção', with: 'Individual (500g)'
      fill_in 'Preço', with: 39
      click_on 'Atualizar porção'

      expect(current_path).to eq restaurant_dish_path(restaurant, dish)
      expect(page).to have_content 'Individual (500g)'
      expect(page).to have_content '39,00'
    end

    it "and should not edit option when fields are empty" do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
      option = ItemOption.create!(description: 'Individual', price: 30, item: dish)

      login_as(user)
      visit edit_restaurant_item_option_path(restaurant, dish, option)
      fill_in 'Descrição da porção', with: ''
      fill_in 'Preço', with: ""
      click_on 'Atualizar porção'

      expect(page).to have_content 'Ocorreu um erro ao atualizar porção'
      expect(page).to have_content 'Descrição da porção não pode ficar em branco'
      expect(page).to have_content 'Preço não pode ficar em branco'
    end

    it "and should not edit option when price is negative" do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, is_active: false, restaurant: restaurant)
      option = ItemOption.create!(description: 'Individual', price: 30, item: dish)

      login_as(user)
      visit edit_restaurant_item_option_path(restaurant, dish, option)
      fill_in 'Preço', with: -1
      click_on 'Atualizar porção'

      expect(page).to have_content 'Ocorreu um erro ao atualizar porção'
      expect(page).to have_content 'Preço deve ser maior que 0'
    end
  end

  context 'update beverage options' do 
    it "and unauthenticated users shouldn't access to the edit form" do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)

      option = ItemOption.create!(description: 'Jarra', price: 30, item: beverage)

      visit edit_restaurant_item_option_path(restaurant, beverage, option)

      expect(page).to have_content 'Para continuar, faça login ou registre-se.'
      expect(current_path).to eq new_user_session_path
    end

    it "and users who do not belong to this restaurant shouldn't access the edit form " do
      first_restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      User.create!(restaurant: first_restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: first_restaurant)
      option = ItemOption.create!(description: 'Jarra', price: 30, item: beverage)
     
                        
      second_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@lanches.com', phone_number: '81987654321')
      second_user = User.create!(restaurant: second_restaurant, email: 'abcd@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      
      login_as(second_user)
      visit edit_restaurant_item_option_path(first_restaurant, beverage, option)

      expect(current_path).to eq root_path
    end

    it 'and when access the edit item_option form from beverage details page should see all fields filled' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)

      option = ItemOption.create!(description: 'Jarra', price: 30, item: beverage)

      login_as(user)
      visit root_path
      click_on 'Bebidas'
      click_on 'Suco de laranja'
      click_on 'Editar porção'

      expect(current_path).to eq edit_restaurant_item_option_path(restaurant, beverage, option)
      expect(page).to have_field 'Descrição da porção', with: 'Jarra'
      expect(page).to have_field 'Preço', with: "30.0"
    end

    it 'and should edit option successfully' do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)

      option = ItemOption.create!(description: 'Jarra', price: 30, item: beverage)

      login_as(user)
      visit edit_restaurant_item_option_path(restaurant, beverage, option)
      fill_in 'Descrição da porção', with: 'Jarra 1L'
      fill_in 'Preço', with: 39
      click_on 'Atualizar porção'

      expect(current_path).to eq restaurant_beverage_path(restaurant, beverage)
      expect(page).to have_content 'Jarra 1L'
      expect(page).to have_content '39,00'
    end

    it "and should not edit option when fields are empty" do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)

      option = ItemOption.create!(description: 'Jarra', price: 30, item: beverage)

      login_as(user)
      visit edit_restaurant_item_option_path(restaurant, beverage, option)
      fill_in 'Descrição da porção', with: ''
      fill_in 'Preço', with: ""
      click_on 'Atualizar porção'

      expect(page).to have_content 'Ocorreu um erro ao atualizar porção'
      expect(page).to have_content 'Descrição da porção não pode ficar em branco'
      expect(page).to have_content 'Preço não pode ficar em branco'
    end

    it "and should not edit option when price is negative" do
      restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
      beverage = Beverage.create!(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)

      option = ItemOption.create!(description: 'Jarra', price: 30, item: beverage)

      login_as(user)
      visit edit_restaurant_item_option_path(restaurant, beverage, option)
      fill_in 'Preço', with: -1
      click_on 'Atualizar porção'

      expect(page).to have_content 'Ocorreu um erro ao atualizar porção'
      expect(page).to have_content 'Preço deve ser maior que 0'
    end
  end
end
