require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe '#valid' do
  it 'false when corporate_name is empty' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.new(corporate_name: '', brand_name: 'hot lanches', cnpj: '84685592000112',
                                full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
    
    expect(restaurant.valid?).to be_falsy
    expect(restaurant.errors[:corporate_name]).to include 'não pode ficar em branco'
  end
  it 'false when brand_name is empty' do
    user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
    restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: '', cnpj: '84685592000112',
                                full_address:'Rua da Hot, 721 - RJ', email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
    
    expect(restaurant.valid?).to be_falsy
    expect(restaurant.errors[:brand_name]).to include 'não pode ficar em branco'
  end
    it 'false when full_address is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'', email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      
      expect(restaurant.valid?).to be_falsy
      expect(restaurant.errors[:full_address]).to include 'não pode ficar em branco'
    end
    it 'false when cnpj is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@hotlanches.com', phone_number: '81987654321', user: user)

      expect(restaurant.valid?).to be_falsy
      expect(restaurant.errors[:cnpj]).to include 'não pode ficar em branco'
    end
    it 'false when cnpj is invalid' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '12345678911',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      
      expect(restaurant.valid?).to be_falsy
      expect(restaurant.errors[:cnpj]).to include 'inválido'
    end
    it 'false when cnpj is not unique' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                         full_address:'Rua da Hot, 721 - RJ', email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      
      expect(restaurant.valid?).to be_falsy
      expect(restaurant.errors[:cnpj]).to include 'já está em uso'
    end
    it 'false when email is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ', email:'', phone_number: '81987654321', user: user)
      
      expect(restaurant.valid?).to be_falsy
      expect(restaurant.errors[:email]).to include 'não pode ficar em branco'
    end
    it 'false when email is invalid' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@gmail', phone_number: '81987654321', user: user)
      
      expect(restaurant.valid?).to be_falsy
      expect(restaurant.errors[:email]).to include 'inválido'
    end
    it 'false when email is not unique' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                         full_address:'Rua da Hot, 721 - RJ', email:'contato@gmail.com', phone_number: '1234567891', user: user)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@gmail.com', phone_number: '123456789012', user: user)

      expect(restaurant.valid?).to be_falsy
      expect(restaurant.errors[:email]).to include 'já está em uso'
    end
    it 'false when phone_number is empty' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@gmail', phone_number: '', user: user)
      
      expect(restaurant.valid?).to be_falsy
      expect(restaurant.errors[:phone_number]).to include 'não pode ficar em branco'
    end
    it 'false when phone_number is less than 9' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@gmail', phone_number: '12345678', user: user)
      
      expect(restaurant.valid?).to be_falsy
      expect(restaurant.errors[:phone_number]).to include 'é muito curta (mínimo: 10 caracteres)'
    end
    it 'false when phone_number is greater than 11' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ', email:'contato@gmail', phone_number: '123456789012', user: user)
      
      expect(restaurant.valid?).to be_falsy
      expect(restaurant.errors[:phone_number]).to include 'é muito longo (máximo: 11 caracteres)'
    end
    it 'false when user already has a restaurant' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                         full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                         full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      
      expect(restaurant.valid?).to be_falsy
      expect(restaurant.errors[:user_id]).to include 'já está em uso'
    end
    it 'true when all mandatory fields is filled and valid' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
  
      expect(restaurant.valid?).to be true
      expect(restaurant.errors).to be_empty 
    end
  end
  
  describe 'generate a random code' do
    it 'when create a new restaurant' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                                  full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
      
      restaurant.save!
      
      expect(restaurant.code).not_to be_empty
      expect(restaurant.code.length).to eq 6
    end
    it 'and the code is unique' do
      first_user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      second_user = User.create!(email: 'joao@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)

      first_restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                            full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: first_user)

      second_restaurant = Restaurant.new(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '84685592000112',
                                        full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: second_user)
      
      second_restaurant.save!                                
   
      expect(second_restaurant.code).not_to eq first_restaurant.code
    end
  end

  describe 'strip cnpj' do
    it 'when create a new restaurant' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)

      restaurant.save!
      
      expect(restaurant.cnpj).to eq '34651791000131'
    end
  end
end
