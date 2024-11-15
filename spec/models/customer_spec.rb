require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe '#valid?' do
    it 'should be false when name is empty' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      customer = Customer.new(cpf: CPF.generate, email: 'joaozinho@gmail.com', restaurant: restaurant)

      expect(customer.valid?).to be_falsy
      expect(customer.errors[:name]).to include 'não pode ficar em branco'
    end

    it 'should be false when both phone_number and email are empty' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      customer = Customer.new(name: 'Joãozinho', cpf: CPF.generate, restaurant: restaurant)

      expect(customer.valid?).to be_falsy
      expect(customer.errors[:phone_number]).to include 'Telefone ou E-mail precisa estar presente'
      expect(customer.errors[:email]).to include 'Telefone ou E-mail precisa estar presente'
    end

    it 'should be false when CPF is invalid' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      customer = Customer.new(name: 'Joãozinho', cpf: '12345678900', email: 'joaozinho@gmail.com', restaurant: restaurant)

      expect(customer.valid?).to be_falsy
      expect(customer.errors[:cpf]).to include 'inválido'
    end

    it 'should be true when all fields are present' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      customer = Customer.new(name: 'Joãozinho', cpf: CPF.generate, phone_number: '81987654321', restaurant: restaurant)

      expect(customer.valid?).to be true
    end
  end

  describe '#customer_description' do
    it 'returns name and phone_number when both email and phone_number are present' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      customer = Customer.create!(name: 'Joãozinho', cpf: CPF.generate, phone_number: '81987654321', email: 'joaozinho@gmail.com', restaurant: restaurant)

      expect(customer.customer_description).to eq 'Joãozinho - 81987654321'
    end

    it 'returns name and email when phone_number is empty' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      customer = Customer.create!(name: 'Joãozinho', cpf: CPF.generate, email: 'joaozinho@gmail.com', restaurant: restaurant)

      expect(customer.customer_description).to eq 'Joãozinho - joaozinho@gmail.com'
    end
  end

  describe '#strip_cpf' do
    it 'should strip CPF before validation' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      customer = Customer.create!(name: 'Joãozinho', cpf: CPF.generate, email: 'joaozinho@gmail.com', restaurant: restaurant)

      expect(customer.cpf).to eq CPF.new(customer.cpf).stripped
    end
  end
end
