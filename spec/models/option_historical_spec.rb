require 'rails_helper'

RSpec.describe OptionHistorical, type: :model do
  describe "#valid" do
    it 'false when historical price is empty' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      item = Item.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = ItemOption.create!(description: 'Teste', price: '1', item: item)

      historical = OptionHistorical.new(historical_price: '', price_changed_at: Time.zone.now, item_option: option)

      expect(historical.valid?).to be_falsy
      expect(historical.errors[:historical_price]).to include 'não pode ficar em branco'
    end 

    it 'false when historical price is negative' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      item = Item.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = ItemOption.create!(description: 'Teste', price: '1', item: item)

      historical = OptionHistorical.new(historical_price: -1, price_changed_at: Time.zone.now, item_option: option)

      expect(historical.valid?).to be_falsy
      expect(historical.errors[:historical_price]).to include 'deve ser maior que 0'
    end 

    it 'false when historical price is zero' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      item = Item.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = ItemOption.create!(description: 'Teste', price: '1', item: item)

      historical = OptionHistorical.new(historical_price: 0, price_changed_at: Time.zone.now, item_option: option)

      expect(historical.valid?).to be_falsy
      expect(historical.errors[:historical_price]).to include 'deve ser maior que 0'
    end 

    it 'false when price_changed_at price is empty' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      item = Item.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = ItemOption.create!(description: 'Teste', price: '1', item: item)

      historical = OptionHistorical.new(historical_price: 10, price_changed_at: '', item_option: option)

      expect(historical.valid?).to be_falsy
      expect(historical.errors[:price_changed_at]).to include 'não pode ficar em branco'
    end 

    it 'false when item_option is empty' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      item = Item.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      ItemOption.create!(description: 'Teste', price: '1', item: item)

      historical = OptionHistorical.new(historical_price: 10, price_changed_at: Time.zone.now, item_option: nil)

      expect(historical.valid?).to be_falsy
      expect(historical.errors[:item_option]).to include 'é obrigatório(a)'
    end 

    it 'true when all fields are filled' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      item = Item.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = ItemOption.create!(description: 'Teste', price: '1', item: item)

      historical = OptionHistorical.new(historical_price: 10, price_changed_at: Time.zone.now, item_option: option)

      expect(historical.valid?).to be true
      expect(option.errors).to be_empty
    end 
  end
end
