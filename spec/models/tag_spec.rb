require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe "#valid" do
    it 'should be false when name isnt present' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                    full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      tag = Tag.new(name: '', restaurant: restaurant)  

      expect(tag.valid?).to be_falsy
      expect(tag.errors[:name]).to include 'não pode ficar em branco'
    end

    it 'should be true when name is present' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                     full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      tag = Tag.new(name: 'Apimentado', restaurant: restaurant)  
    
      expect(tag.valid?).to be true
      expect(tag.errors).to be_empty
    end
  end
end
