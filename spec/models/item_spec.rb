require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "#valid" do
    it 'false when name is empty' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      item = Item.new(name: '', description: 'testando', calories: 10, restaurant: restaurant)

      expect(item.valid?).to be_falsy
      expect(item.errors[:name]).to include 'não pode ficar em branco'
    end
    it 'false when description is empty' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      item = Item.new(name: 'Teste', description: '', calories: 10, restaurant: restaurant)

      expect(item.valid?).to be_falsy
      expect(item.errors[:description]).to include 'não pode ficar em branco'
    end 
    it 'false when calories is negative' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      item = Item.new(name: 'Teste', description: 'testando', calories: -1, restaurant: restaurant)

      expect(item.valid?).to be_falsy
      expect(item.errors[:calories]).to include 'não pode ser negativa'
    end 
    it 'false when file format is invalid' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      item = Item.new(name: 'Teste', description: 'testando', calories: -1, restaurant: restaurant)

      item.image.attach(Rails.root.join("spec/fixtures/files/teste.txt"))
      expect(item.valid?).to be_falsy
      expect(item.errors[:image]).to include 'deve ser JPEG ou PNG'
    end

    it 'true when all mandatory fields are filled correctly' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      User.create!(restaurant: restaurant, email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      item = Item.new(name: 'Teste', description: 'testando', calories: 200, restaurant: restaurant)

      item.image.attach(Rails.root.join("spec/fixtures/files/test_image.png"))

      expect(item.valid?).to be true
      expect(item.errors).to be_empty
    end  
  end
end

