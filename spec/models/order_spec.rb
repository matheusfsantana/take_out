require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid' do
    it 'should be false when no order items are associated' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)

      order = Order.new(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: []
      )

      expect(order.valid?).to be_falsy
      expect(order.errors[:order_item].first).to include 'deve conter pelo menos um item.'
    end
    it 'should be false when no customer are associated' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)

      order = Order.new(
        restaurant: restaurant,
        order_items_attributes: []
      )

      expect(order.valid?).to be_falsy
      expect(order.errors[:customer].first).to include 'é obrigatório(a)'
    end
  end

  describe 'generate a random code' do
    it 'when create a new order' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      first_item_option = ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      second_item_option = ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)
      
      order = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
          { item_option: first_item_option, observation: 'teste'},
          { item_option: second_item_option }
        ])

      expect(order.code).not_to be_empty
      expect(order.code.length).to eq 8    
    end

    it 'and the code is unique' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      first_item_option = ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      second_item_option = ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)

      order1 = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
        { item_option: first_item_option, observation: 'teste'},
        { item_option: second_item_option }
        ])

      order2 = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
        { item_option: first_item_option, observation: 'teste'},
        { item_option: second_item_option }
        ])

      expect(order1.code).not_to eq(order2.code)
    end
  end

  describe 'calculate total' do
    it 'calculates the total based on associated item options prices' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      first_item_option = ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      second_item_option = ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)

      order = Order.new(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
        { item_option: first_item_option, observation: 'teste'},
        { item_option: second_item_option }
        ]
      )
      order.validate
      expect(order.valid?).to be true
      expect(order.total).to eq('25.00')
    end
  end

  describe 'set default values' do
    it 'sets default status and order_date on creation' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      first_item_option = ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      second_item_option = ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)

      order = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
        { item_option: first_item_option, observation: 'teste'},
        { item_option: second_item_option }
        ]
      )

      expect(order.status).to eq('pending_confirmation')
      expect(order.order_date).not_to be_nil
    end
  end
end
