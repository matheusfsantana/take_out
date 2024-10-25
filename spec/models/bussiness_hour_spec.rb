require 'rails_helper'

RSpec.describe BussinessHour, type: :model do
  describe '#valid' do
    it 'false when opening_hour is empty and is_open is true' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: '', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      
      bussiness_hour = BussinessHour.new(day_of_week: 'Segunda', opening_hour: '', closing_hour: '9:00', is_open: true, restaurant: restaurant)

      bussiness_hour.opening_hour = ''
      bussiness_hour.is_open = true

      expect(bussiness_hour.valid?).to be_falsy
      expect(bussiness_hour.errors[:opening_hour]).to include 'é obrigatório quando o estabelecimento está aberto'
    end
    it 'false when closing_hour is empty and is_open is true' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: '', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      
      bussiness_hour = BussinessHour.new(day_of_week: 'Segunda', opening_hour: '9:00', closing_hour: '', is_open: true, restaurant: restaurant)

      expect(bussiness_hour.valid?).to be_falsy
      expect(bussiness_hour.errors[:closing_hour]).to include 'é obrigatório quando o estabelecimento está aberto'
    end
    it 'false when opening_hour is greater than closing_hour' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: '', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      
      bussiness_hour = BussinessHour.new(day_of_week: 'Segunda', opening_hour: '01:00', closing_hour: '00:59', is_open: true, restaurant: restaurant)

      expect(bussiness_hour.valid?).to be_falsy
      expect(bussiness_hour.errors[:closing_hour]).to include 'deve ser maior que horário de abertura'
    end
    it 'true when all fields are valid' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: '', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      
      bussiness_hour = BussinessHour.new(day_of_week: 'Segunda', opening_hour: '01:00', closing_hour: '01:00', is_open: true, restaurant: restaurant)

      expect(bussiness_hour.valid?).to be true
    end
  end
end
