require 'rails_helper'

RSpec.describe ItemOption, type: :model do
  describe "#valid" do
    it 'false when description is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      item = Item.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = ItemOption.new(description: '', price: 19, item: item)

      expect(option.valid?).to be_falsy
      expect(option.errors[:description]).to include 'não pode ficar em branco'
    end 

    it 'false when price is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      item = Item.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = ItemOption.new(description: 'Teste', price: '', item: item)

      expect(option.valid?).to be_falsy
      expect(option.errors[:price]).to include 'não pode ficar em branco'
    end 

    it 'false when price is 0' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      item = Item.create!(name: 'Teste', description: 'testando', calories: 10, restaurant: restaurant)
      option = ItemOption.new(description: 'Teste', price: 0, item: item)

      expect(option.valid?).to be_falsy
      expect(option.errors[:price]).to include 'deve ser maior que 0'
    end 

    it 'false when price is -1' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      item = Item.create!(name: 'Teste', description: 'testando', calories: 10, restaurant: restaurant)
      option = ItemOption.new(description: 'Teste', price: -1, item: item)

      expect(option.valid?).to be_falsy
      expect(option.errors[:price]).to include 'deve ser maior que 0'
    end 

    it 'false when item is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      Item.create!(name: 'Teste', description: 'testando', calories: 10, restaurant: restaurant)
      option = ItemOption.new(description: 'Teste', price: -1, item: nil)

      expect(option.valid?).to be_falsy
      expect(option.errors[:item]).to include 'é obrigatório(a)'
    end 

    it 'true when description is filled and price is greather than 0' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      item = Item.create!(name: 'Teste', description: 'a', calories: 10, restaurant: restaurant)
      option = ItemOption.new(description: 'Teste', price: '1', item: item)

      expect(option.valid?).to be true
      expect(option.errors).to be_empty
    end  
  end
end
