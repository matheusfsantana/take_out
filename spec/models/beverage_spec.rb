require 'rails_helper'

RSpec.describe Beverage, type: :model do
  describe "#valid" do
    it 'should be FALSE when alcoholic isnt true or false' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      beverage = Beverage.new(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: '', restaurant: restaurant)

      expect(beverage.valid?).to be_falsy
      expect(beverage.errors[:alcoholic]).to include 'não está incluído na lista'
    end
    it 'should be TRUE when alcoholic is true or false' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      first_beverage = Beverage.new(name: 'Suco de laranja', description: 'Suco feito da polpa', calories: 100, alcoholic: false, restaurant: restaurant)
      second_beverage = Beverage.new(name: 'Cerveja', description: 'Cerveja artesanal da casa', calories: 400, alcoholic: true, restaurant: restaurant)

      expect(first_beverage.valid?).to be true
      expect(second_beverage.valid?).to be true    
    end

  end
end
