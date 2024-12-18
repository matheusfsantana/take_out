require 'rails_helper'

describe 'User search for item' do
  it "and shouldn't see the search form if isn't authenticated" do
    visit root_path

    within 'nav' do
      expect(page).not_to have_selector('form#search_form')
    end
  end

  it "and shouldn't see the search form if the user doesn't have a restaurant" do
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    
    login_as(user)
    visit root_path

    within 'nav' do
      expect(page).not_to have_selector('form#search_form')
    end
  end

  it "and should see the search form if the user has a restaurant and is on the ROOT PATH" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    
    login_as(user)
    visit root_path

    within 'nav' do
      expect(page).to have_selector('form#search_form') 
    end
    expect(current_path).to eq root_path
  end
  it "and should see the search form on the RESTAURANT_DISHES_PATH" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    
    login_as(user)
    visit root_path
    click_on 'Pratos'

    within 'nav' do
      expect(page).to have_selector('form#search_form') 
    end
    expect(current_path).to eq dishes_path
  end
  it "and should see the search form on the RESTAURANT_BEVERAGES_PATH" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    
    login_as(user)
    visit root_path
    click_on 'Bebidas'

    within 'nav' do
      expect(page).to have_selector('form#search_form') 
    end
    expect(current_path).to eq beverages_path
  end
  it "and should see the search form on the RESTAURANT_BUSSINESS_HOURS_PATH" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    
    login_as(user)
    visit root_path
    click_on 'Horário de Funcionamento'

    within 'nav' do
      expect(page).to have_selector('form#search_form') 
    end
    expect(current_path).to eq bussiness_hours_path
  end
  it "and should search successfull for dishes and beverages names" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    Dish.create!(name: 'Cereja', description: 'testando', calories: 10, restaurant: restaurant)
    Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300, alcoholic: true, restaurant: restaurant)

    login_as(user)
    visit root_path
    
    fill_in 'query', with: "Cer"
    click_on 'Buscar'

    expect(current_path).to eq items_search_path
    expect(page).to have_content 'Resultados da busca por: "Cer"'
    expect(page).to have_content 'Cereja'
    expect(page).to have_content 'Cerveja'
  end
  it "and should search successfull for dishes and beverages descriptions" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, restaurant: restaurant)
    Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300, alcoholic: true, restaurant: restaurant)

    login_as(user)
    visit root_path
    
    fill_in 'query', with: "Casa"
    click_on 'Buscar'

    expect(current_path).to eq items_search_path
    expect(page).to have_content 'Resultados da busca por: "Casa"'
    expect(page).to have_content 'Bife a cavalo'
    expect(page).to have_content 'Prato da casa'
    expect(page).to have_content 'Cerveja'
    expect(page).to have_content 'Cerveja artesanal da casa'
  end
  it "and should display a message when no results are found" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, restaurant: restaurant)
    Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300, alcoholic: true, restaurant: restaurant)

    login_as(user)
    visit root_path
    
    fill_in 'query', with: "teste pesquisa"
    click_on 'Buscar'

    expect(current_path).to eq items_search_path
    expect(page).to have_content 'Resultados da busca por: "teste pesquisa"'
    expect(page).to have_content 'Nenhum prato encontrado'
    expect(page).to have_content 'Nenhuma bebida encontrada'
  end
  it "and should search successfull for dishes and beverages descriptions and access to the DISH EDIT PAGE" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, restaurant: restaurant)

    login_as(user)
    visit root_path
    
    fill_in 'query', with: "Casa"
    click_on 'Buscar'
    click_on 'Editar Prato'

    expect(current_path).to eq edit_dish_path(dish)
    expect(page).to have_field 'Nome', with: 'Bife a cavalo'
    expect(page).to have_field 'Descrição', with: 'Prato da casa'
    expect(page).to have_field 'Calorias', with: '10'
    expect(page).to have_field 'Imagem'
  end
  it "and should search successfull for dishes and beverages descriptions and access to the BEVERAGE EDIT PAGE" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    beverage = Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300, alcoholic: true, restaurant: restaurant)

    login_as(user)
    visit root_path
    
    fill_in 'query', with: "Casa"
    click_on 'Buscar'
    click_on 'Editar Bebida'

    expect(current_path).to eq edit_beverage_path(beverage)
    expect(page).to have_field 'Nome', with: 'Cerveja'
    expect(page).to have_field 'Descrição', with: 'Cerveja artesanal da casa'
    expect(page).to have_field 'Calorias', with: '300'
    expect(page).to have_checked_field 'Alcoólico'
    expect(page).to have_field 'Imagem'
  end
  it "and should search successfull for dishes and beverages descriptions and access to the DISH DETAILS PAGE" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    dish = Dish.create!(name: 'Bife a cavalo', description: 'Prato da casa', calories: 10, restaurant: restaurant)

    login_as(user)
    visit root_path
    
    fill_in 'query', with: "Casa"
    click_on 'Buscar'
    click_on 'Bife a cavalo'

    expect(current_path).to eq dish_path(dish)
  end
  it "and should search successfull for dishes and beverages descriptions and access to the BEVERAGE DETAILS PAGE" do
    restaurant = Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    beverage = Beverage.create!(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 300, alcoholic: true, restaurant: restaurant)

    login_as(user)
    visit root_path
    
    fill_in 'query', with: "Casa"
    click_on 'Buscar'
    click_on 'Cerveja'

    expect(current_path).to eq beverage_path(beverage)
  end
end