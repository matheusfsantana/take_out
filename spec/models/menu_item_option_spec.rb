require 'rails_helper'

RSpec.describe MenuItemOption, type: :model do
  describe "#valid" do
    it 'false when description is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu_item = MenuItem.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = MenuItemOption.new(description: '', price: 19, menu_item: menu_item)

      expect(option.valid?).to be_falsy
      expect(option.errors[:description]).to include 'não pode ficar em branco'
    end 

    it 'false when price is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu_item = MenuItem.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = MenuItemOption.new(description: 'Teste', price: '', menu_item: menu_item)

      expect(option.valid?).to be_falsy
      expect(option.errors[:price]).to include 'não pode ficar em branco'
    end 

    it 'false when price is 0' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu_item = MenuItem.create!(name: 'Teste', description: 'testando', calories: 10, restaurant: restaurant)
      option = MenuItemOption.new(description: 'Teste', price: 0, menu_item: menu_item)

      expect(option.valid?).to be_falsy
      expect(option.errors[:price]).to include 'deve ser maior que 0'
    end 

    it 'false when price is -1' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu_item = MenuItem.create!(name: 'Teste', description: 'testando', calories: 10, restaurant: restaurant)
      option = MenuItemOption.new(description: 'Teste', price: -1, menu_item: menu_item)

      expect(option.valid?).to be_falsy
      expect(option.errors[:price]).to include 'deve ser maior que 0'
    end 

    it 'false when menu_item is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      MenuItem.create!(name: 'Teste', description: 'testando', calories: 10, restaurant: restaurant)
      option = MenuItemOption.new(description: 'Teste', price: -1, menu_item: nil)

      expect(option.valid?).to be_falsy
      expect(option.errors[:menu_item]).to include 'é obrigatório(a)'
    end 

    it 'true when description is filled and price is greather than 0' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu_item = MenuItem.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = MenuItemOption.new(description: 'Teste', price: '1', menu_item: menu_item)

      expect(option.valid?).to be true
      expect(option.errors).to be_empty
    end  
  end
end
