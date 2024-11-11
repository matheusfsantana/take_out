require 'rails_helper'

describe 'User filter dish by tag' do
  it 'and should filter only dishs and tags of your restaurant' do
    first_user_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                               full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    User.create!(restaurant: first_user_restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)

    first_dish = Dish.create!(name: 'Prato primeiro usuario', description: 'testando', calories: 10, restaurant: first_user_restaurant)
    first_user_tag = Tag.create!(name: 'Apimentado', restaurant: first_user_restaurant)
    ItemTag.create!(item: first_dish, tag: first_user_tag)

    second_user_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                                full_address:'Rua da Hot, 721 - RJ',email:'contato@lanches.com', phone_number: '81987654321')
    second_user = User.create!(restaurant: second_user_restaurant, email: 'abcd@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    second_dish = Dish.create!(name: 'Prato segundo usuario', description: 'testando', calories: 10, restaurant: second_user_restaurant)
    second_user_tag = Tag.create!(name: 'Apimentado', restaurant: second_user_restaurant)
    ItemTag.create!(item: second_dish, tag: second_user_tag)

    login_as(second_user)
    visit dishes_path
    select 'Apimentado', from: 'filter_tag'
    click_on 'Filtrar'

    expect(page).to have_content('Prato segundo usuario')
    expect(page).not_to have_content('Prato primeiro usuario')
  end

  it 'and should filter successfully' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                               full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    dish = Dish.create!(name: 'Primeiro prato', description: 'testando', calories: 10, restaurant: restaurant)
    second_dish = Dish.create!(name: 'Segundo prato', description: 'testando', calories: 10, restaurant: restaurant)
    third_dish = Dish.create!(name: 'Terceiro prato', description: 'testando', calories: 10, restaurant: restaurant)

    first_tag = Tag.create!(name: 'Apimentado', restaurant: restaurant)
    second_tag = Tag.create!(name: 'Vegano', restaurant: restaurant)

    ItemTag.create!(item:  dish, tag: first_tag)
    ItemTag.create!(item:  second_dish, tag: first_tag)
    ItemTag.create!(item:  third_dish, tag: second_tag)


   
    login_as(user)
    visit dishes_path
    select 'Apimentado', from: 'filter_tag'
    click_on 'Filtrar'

    expect(page).to have_content('Primeiro prato')
    expect(page).to have_content('Segundo prato')
    expect(page).not_to have_content('Terceiro prato')
  end

  it 'and should clean filter successfully' do
    restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                               full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
    user = User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    dish = Dish.create!(name: 'Primeiro prato', description: 'testando', calories: 10, restaurant: restaurant)
    second_dish = Dish.create!(name: 'Segundo prato', description: 'testando', calories: 10, restaurant: restaurant)
    third_dish = Dish.create!(name: 'Terceiro prato', description: 'testando', calories: 10, restaurant: restaurant)

    first_tag = Tag.create!(name: 'Apimentado', restaurant: restaurant)
    second_tag = Tag.create!(name: 'Vegano', restaurant: restaurant)

    ItemTag.create!(item:  dish, tag: first_tag)
    ItemTag.create!(item:  second_dish, tag: first_tag)
    ItemTag.create!(item:  third_dish, tag: second_tag)


   
    login_as(user)
    visit dishes_path
    select 'Apimentado', from: 'filter_tag'
    click_on 'Filtrar'
    click_on 'Limpar'

    expect(page).to have_content('Primeiro prato')
    expect(page).to have_content('Segundo prato')
    expect(page).to have_content('Terceiro prato')
  end
end