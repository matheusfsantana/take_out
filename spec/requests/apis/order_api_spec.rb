require 'rails_helper'

describe 'Order API' do 
  context 'GET /api/v1/restaurants/:restaurant_code/orders/:order_code' do
    it 'success' do     
      allow(SecureRandom).to receive(:alphanumeric).and_return("REST99") 
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      first_item_option = ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      second_item_option = ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)
      
      fixed_time = Time.zone.local(2024, 11, 12, 10, 0, 0)
      allow(Time.zone).to receive(:now).and_return(fixed_time)
      allow(SecureRandom).to receive(:alphanumeric).and_return("ORDER999")
      order = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
          { item_option: first_item_option, observation: 'teste'},
          { item_option: second_item_option }
        ])
      order.pending_kitchen!
      
      get "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}"

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)

      expect(json_response['customer']['name']).to eq 'Joãozinho'
      expect(json_response['customer']['email']).to eq 'cliente@gmail.com'
      expect(json_response['customer']['phone_number']).to eq '81987654321'
      expect(json_response['code']).to eq "ORDER999"
      expect(json_response['status']).to eq "Pendente de confirmação da cozinha"
      expect(json_response['order_date']).to eq "2024-11-12T10:00:00.000Z"
      expect(json_response['order_items'][0]['description']).to eq 'Batata pequena'
      expect(json_response['order_items'][0]['price_at_order']).to eq '10.0'
      expect(json_response['order_items'][0]['observation']).to eq 'teste'
      expect(json_response['order_items'][1]['description']).to eq 'Batata grande'
      expect(json_response['order_items'][1]['price_at_order']).to eq '15.0'
      expect(json_response['total']).to eq '25.0'
    end

    it 'fail' do 
      get "/api/v1/restaurants/99999/orders/99999"

      expect(response.status).to eq 404
    end
  end

  context 'GET /api/v1/restaurants/:restaurant_code/orders/?status=' do
    it 'return all orders when status param is not provided' do
      allow(SecureRandom).to receive(:alphanumeric).and_return("REST99") 
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      first_item_option = ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      second_item_option = ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)
      
      allow(SecureRandom).to receive(:alphanumeric).and_return("ORDER999")
      first_order = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
          { item_option: first_item_option, observation: 'teste'},
          { item_option: second_item_option }
        ])
      first_order.pending_kitchen!

      second_order = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
          { item_option: first_item_option, observation: 'teste'},
          { item_option: second_item_option }
        ])
      second_order.ready!

      third_order = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
          { item_option: first_item_option, observation: 'teste'},
          { item_option: second_item_option }
        ])
      third_order.in_preparation!

      get "/api/v1/restaurants/#{restaurant.code}/orders"

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq 3
      expect(json_response[0]['status']).to eq "Pendente de confirmação da cozinha"
      expect(json_response[1]['status']).to eq "Pronto para retirada"
      expect(json_response[2]['status']).to eq "Em preparação"
    end

    it 'return only orders with the specifed status when status param is provided' do
      allow(SecureRandom).to receive(:alphanumeric).and_return("REST99") 
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      first_item_option = ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      second_item_option = ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)
      
      allow(SecureRandom).to receive(:alphanumeric).and_return("ORDER999")
      first_order = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
          { item_option: first_item_option, observation: 'teste'},
          { item_option: second_item_option }
        ])
      first_order.pending_kitchen!

      second_order = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
          { item_option: first_item_option, observation: 'teste'},
          { item_option: second_item_option }
        ])
      second_order.ready!

      third_order = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
          { item_option: first_item_option, observation: 'teste'},
          { item_option: second_item_option }
        ])
      third_order.in_preparation!

      get "/api/v1/restaurants/#{restaurant.code}/orders/?status=#{second_order.status}"

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq 1
      expect(json_response[0]['status']).to eq 'Pronto para retirada'
    end

    it 'empty when no orders are registered' do
      allow(SecureRandom).to receive(:alphanumeric).and_return("REST99") 
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')

      get "/api/v1/restaurants/#{restaurant.code}/orders"

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
    end
  end

  context 'POST /api/v1/restaurants/:restaurant_code/orders/:order_code/to_preparation' do
    it 'successfully changes order status to in preparation' do
      allow(SecureRandom).to receive(:alphanumeric).and_return("REST99") 
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      first_item_option = ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      second_item_option = ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)
      
      allow(SecureRandom).to receive(:alphanumeric).and_return("ORDER999")
      order = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
          { item_option: first_item_option, observation: 'teste'},
          { item_option: second_item_option }
        ])
      order.pending_kitchen!
  
      post "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}/to_preparation"
  
      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response).to eq({}) 
      expect(order.reload.status).to eq 'in_preparation'
    end
  
    it 'returns not found when order does not exist' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
  
      post "/api/v1/restaurants/#{restaurant.code}/orders/99999/to_preparation"
  
      expect(response.status).to eq 404
    end
  end
  
  context 'POST /api/v1/restaurants/:restaurant_code/orders/:order_code/to_ready' do
    it 'successfully changes order status to ready' do
      allow(SecureRandom).to receive(:alphanumeric).and_return("REST99") 
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      first_dish = Dish.create!(name: 'Batata frita', description: 'testando', calories: 10, restaurant: restaurant)
      first_item_option = ItemOption.create!(description: 'Batata pequena', price: 10.00, item: first_dish)
      second_item_option = ItemOption.create!(description: 'Batata grande', price: 15.00, item: first_dish)
      customer = Customer.create!(name: 'Joãozinho', email: 'cliente@gmail.com', phone_number: '81987654321', cpf: CPF.generate, restaurant: restaurant)
      
      allow(SecureRandom).to receive(:alphanumeric).and_return("ORDER999")
      order = Order.create!(
        customer: customer,
        restaurant: restaurant,
        order_items_attributes: [
          { item_option: first_item_option, observation: 'teste'},
          { item_option: second_item_option }
        ])
      order.in_preparation!
  
      post "/api/v1/restaurants/#{restaurant.code}/orders/#{order.code}/to_ready"
  
      expect(response.status).to eq 200
      json_response = JSON.parse(response.body)
      expect(json_response).to eq({}) 
      expect(order.reload.status).to eq 'ready'
    end
  
    it 'returns not found when order does not exist' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                      full_address: 'Rua da Hot, 721 - RJ', email: 'contato@lancheshot.com', phone_number: '81987654321')
  
      post "/api/v1/restaurants/#{restaurant.code}/orders/99999/to_ready"
  
      expect(response.status).to eq 404
    end
  end
end