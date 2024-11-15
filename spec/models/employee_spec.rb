require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe '#valid?' do
    it 'should be true when all fields are present' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                      full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      employee = Employee.new(cpf: CPF.generate, email: "employee@restaurant.com", restaurant: restaurant)

      expect(employee.valid?).to be true
      expect(employee.errors).to be_empty
    end

    it 'should be false when email is empty' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      employee = Employee.new(cpf: CPF.generate, restaurant: restaurant)

      expect(employee.valid?).to be_falsy
      expect(employee.errors[:email]).to include 'não pode ficar em branco'
    end

    it 'should be false when cpf is empty' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      employee = Employee.new(email: 'employee@restaurant.com', restaurant: restaurant)

      expect(employee.valid?).to be_falsy
      expect(employee.errors[:cpf]).to include 'não pode ficar em branco'
    end

    it 'should be false when email is invalid' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      employee = Employee.new(email: 'invalid_email', cpf: CPF.generate, restaurant: restaurant)

      expect(employee.valid?).to be_falsy
      expect(employee.errors[:email]).to include 'inválido'
    end

    it 'should be false when cpf is invalid' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      employee = Employee.new(email: 'employee@restaurant.com', cpf: '12345678900', restaurant: restaurant)

      expect(employee.valid?).to be_falsy
      expect(employee.errors[:cpf]).to include 'inválido'
    end

    it 'should be false when email is not unique' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      Employee.create!(email: 'employee@restaurant.com', cpf: CPF.generate, restaurant: restaurant)
      second_employee = Employee.new(email: 'employee@restaurant.com', cpf: CPF.generate, restaurant: restaurant)

      expect(second_employee.valid?).to be_falsy
      expect(second_employee.errors[:email]).to include 'já está em uso'
    end

    it 'should be false when cpf is not unique' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      first_employee =Employee.create!(email: 'employee1@restaurant.com', cpf: CPF.generate, restaurant: restaurant)
      second_employee = Employee.new(email: 'employee2@restaurant.com', cpf: first_employee.cpf, restaurant: restaurant)

      expect(second_employee.valid?).to be_falsy
      expect(second_employee.errors[:cpf]).to include 'já está em uso'
    end
  end

  describe '#set_default' do
    it 'sets default values on create' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'Hot Lanches', cnpj: CNPJ.generate,
                                       full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      employee = Employee.create!(email: 'employee@restaurant.com', cpf: CPF.generate, restaurant: restaurant)

      expect(employee.is_registered).to be_falsy
    end
  end
end
