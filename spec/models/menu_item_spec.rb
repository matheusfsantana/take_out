require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  describe '#valid' do
    it 'should be true when the same dish or beverage are registered for different menus' do
      user = User.create!(email: 'joaozinho@gmail.com', password: 'password1234', name: 'Joao', last_name: 'da Silva', cpf: CPF.generate)
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: '34.651.791/0001-31',
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321', user: user)
      dish = Dish.create!(name: 'Pão com queijo', description: 'testando', calories: 10, restaurant: restaurant)
      beverage = Beverage.create!(name: 'Café', description: 'teste', calories: 300, alcoholic: true, restaurant: restaurant)
      first_menu = Menu.create!(name: 'Café da manhã', restaurant: restaurant)
      second_menu = Menu.create!(name: 'Lanche da tarde', restaurant: restaurant)
      MenuItem.create!(item: dish, menu: first_menu)
      MenuItem.create!(item: beverage, menu: first_menu)
      second_menu_dish_item = MenuItem.new(item: dish, menu: second_menu)
      second_menu_beverage_item = MenuItem.new(item: beverage, menu: second_menu)

      expect(second_menu_dish_item.valid?).to be true
      expect(second_menu_beverage_item.valid?).to be true
    end
  end
end
