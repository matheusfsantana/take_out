require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "#valid" do
    it 'should be false when name isnt present' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      tag = Tag.create!(name: 'Apimentado', restaurant: restaurant)  

      expect(tag.valid?).to be_falsy
      expect(tag.errors[:alcoholic]).to include 'não está incluído na lista'
    end
    it 'should be true when name is present' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      Tag.create!(name: 'Apimentado', restaurant: restaurant)  
      Tag.create!(name: 'Sem glúten', restaurant: restaurant)  

                        
      second_user = User.create!(email: 'abcd@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                        full_address:'Rua da Hot, 721 - RJ',email:'contato@lanches.com', phone_number: '81987654321', user: second_user)


      login_as(second_user)
      click_on 'Marcadores'

      expect(page).not_to have_content 'Apimentado'
      expect(page).not_to have_content 'Sem glúten' 
    end
  end
end
