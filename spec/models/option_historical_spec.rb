require 'rails_helper'

RSpec.describe OptionHistorical, type: :model do
  describe "#valid" do
    it 'false when historical price is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu_item = MenuItem.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = MenuItemOption.create!(description: 'Teste', price: '1', menu_item: menu_item)

      historical = OptionHistorical.new(historical_price: '', price_changed_at: Time.zone.now, menu_item_option: option)

      expect(historical.valid?).to be_falsy
      expect(historical.errors[:historical_price]).to include 'não pode ficar em branco'
    end 

    it 'false when historical price is negative' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu_item = MenuItem.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = MenuItemOption.create!(description: 'Teste', price: '1', menu_item: menu_item)

      historical = OptionHistorical.new(historical_price: -1, price_changed_at: Time.zone.now, menu_item_option: option)

      expect(historical.valid?).to be_falsy
      expect(historical.errors[:historical_price]).to include 'deve ser maior que 0'
    end 

    it 'false when historical price is zero' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu_item = MenuItem.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = MenuItemOption.create!(description: 'Teste', price: '1', menu_item: menu_item)

      historical = OptionHistorical.new(historical_price: 0, price_changed_at: Time.zone.now, menu_item_option: option)

      expect(historical.valid?).to be_falsy
      expect(historical.errors[:historical_price]).to include 'deve ser maior que 0'
    end 

    it 'false when price_changed_at price is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu_item = MenuItem.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = MenuItemOption.create!(description: 'Teste', price: '1', menu_item: menu_item)

      historical = OptionHistorical.new(historical_price: 10, price_changed_at: '', menu_item_option: option)

      expect(historical.valid?).to be_falsy
      expect(historical.errors[:price_changed_at]).to include 'não pode ficar em branco'
    end 

    it 'false when menu_item_option is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu_item = MenuItem.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      MenuItemOption.create!(description: 'Teste', price: '1', menu_item: menu_item)

      historical = OptionHistorical.new(historical_price: 10, price_changed_at: Time.zone.now, menu_item_option: nil)

      expect(historical.valid?).to be_falsy
      expect(historical.errors[:menu_item_option]).to include 'é obrigatório(a)'
    end 

    it 'true when all fields are filled' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu_item = MenuItem.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = MenuItemOption.create!(description: 'Teste', price: '1', menu_item: menu_item)

      historical = OptionHistorical.new(historical_price: 10, price_changed_at: Time.zone.now, menu_item_option: option)

      expect(historical.valid?).to be true
      expect(option.errors).to be_empty
    end 
  end
end
