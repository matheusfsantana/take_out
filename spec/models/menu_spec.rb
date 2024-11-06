require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe '#valid' do
    it 'should be false when name is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu = Menu.new(restaurant: restaurant, name: '')

      expect(menu.valid?).to be_falsy
      expect(menu.errors[:name].first).to include 'não pode ficar em branco'
    end

    it 'should be false when name already exists for your restaurant' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      Menu.create!(restaurant: restaurant, name: 'Executivo')
      menu = Menu.new(restaurant: restaurant, name: 'Executivo')

      expect(menu.valid?).to be_falsy
      expect(menu.errors[:name].first).to include 'já existente para seu restaurante'
    end

    it 'should be false when name already exists for your restaurant with insensitive case' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      Menu.create!(restaurant: restaurant, name: 'eXeCuTiVo')
      menu = Menu.new(restaurant: restaurant, name: 'EXECUTIVO')

      expect(menu.valid?).to be_falsy
      expect(menu.errors[:name].first).to include 'já existente para seu restaurante'
    end

    it 'should be true when name already but for OTHER restaurant' do
      first_user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      first_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: first_user)
      Menu.create!(restaurant: first_restaurant, name: 'Executivo')

      second_user = User.create!(email: 'joao@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      second_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lanches.com', phone_number: '81987654321', user: second_user)

      menu = Menu.new(restaurant: second_restaurant, name: 'Executivo')

      expect(menu.valid?).to be true
      expect(menu.errors).to be_empty
    end

    it 'should be true when name is filled' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      menu = Menu.new(restaurant: restaurant, name: 'Executivo')

      expect(menu.valid?).to be true
      expect(menu.errors).to be_empty
    end
  end
end
