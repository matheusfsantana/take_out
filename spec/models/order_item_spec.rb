require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '#price_at_order' do
    it 'sets the price_at_order from the associated item_option price on creation' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      item_option = ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)

      Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
        { item_option: item_option, observation: 'teste'},
      ])
    
      order_item = OrderItem.last
      expect(order_item.price_at_order).to eq(sprintf('%.2f', item_option.price))
    end
  end

  describe '#set_observation' do
    it 'sets the observation to "-" if not provided' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      item_option = ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)

      Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
        { item_option: item_option, observation: nil},
      ])
    
      order_item = OrderItem.last
      expect(order_item.observation).to eq('-')
    end
  end
end
