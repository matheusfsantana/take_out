require 'rails_helper'

describe 'User and guests search for a order' do
  context 'Guests' do 
    it 'and should see the search form' do
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


      visit orders_search_path

      expect(current_path).to eq orders_search_path
      expect(page).to have_field "code"
    end

    it 'and should search successfully' do
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
      fixed_time = Time.zone.local(2024, 11, 12, 10, 10, 10)
      allow(Time.zone).to receive(:now).and_return(fixed_time)
      order.pending_kitchen!


      visit orders_search_path
      within "#order_search_form" do
        fill_in 'code', with: 'ORDER999'
        click_on 'Buscar'
      end

      expect(current_path).to eq orders_result_path
      expect(page).to have_content "Pedido ORDER999"
      expect(page).to have_content "Restaurante: hot lanches"
      expect(page).to have_content "Endereço: Rua da Hot, 721 - RJ"
      expect(page).to have_content "Contato: 81987654321"
      expect(page).to have_content "Data do Pedido"
      expect(page).to have_content "12/11/2024 07:00" # Por causa da formatação para fuso horario do brasil
      expect(page).to have_content "Início do Preparo"
      expect(page).to have_content "12/11/2024 07:10"
      expect(page).to have_content "Pedido Pronto"
      expect(page).to have_content "Pedido Retirado"
      expect(page).to have_content "Cancelado"
      expect(page).to have_content "N/A"
    end

    it 'and should show a message when no order was found' do 
      visit orders_search_path
      within "#order_search_form" do
      fill_in 'code', with: '9999999'
      click_on 'Buscar'
      end

      expect(page).to have_content 'Pedido não encontrado.'
    end
  end

  context 'Authenticated users' do
    it 'and should see the search form' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                        full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
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

      login_as(user)
      visit orders_search_path

      expect(current_path).to eq orders_search_path
      expect(page).to have_field "code"
    end

    it 'and should search successfully' do
      restaurant = Restaurant.create!(corporate_name: 'Hot Lanches', brand_name: 'hot lanches', cnpj: CNPJ.generate,
                                        full_address:'Rua da Hot, 721 - RJ',email:'contato@lancheshot.com', phone_number: '81987654321')
      user = User.create!(restaurant: restaurant, email: 'admin@gmail.com', name: 'Admin', last_name: 'adm', cpf: CPF.generate, password: 'password1234')
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
      fixed_time = Time.zone.local(2024, 11, 12, 10, 10, 10)
      allow(Time.zone).to receive(:now).and_return(fixed_time)
      order.pending_kitchen!

      login_as(user)
      visit orders_search_path
      within "#order_search_form" do
        fill_in 'code', with: 'ORDER999'
        click_on 'Buscar'
      end

      save_page
      expect(current_path).to eq orders_result_path
      expect(page).to have_content "Pedido ORDER999"
      expect(page).to have_content "Restaurante: hot lanches"
      expect(page).to have_content "Endereço: Rua da Hot, 721 - RJ"
      expect(page).to have_content "Contato: 81987654321"
      expect(page).to have_content "Data do Pedido"
      expect(page).to have_content "12/11/2024 07:00" # Por causa da formatação para fuso horario do brasil
      expect(page).to have_content "Início do Preparo"
      expect(page).to have_content "12/11/2024 07:10"
      expect(page).to have_content "Pedido Pronto"
      expect(page).to have_content "Pedido Retirado"
      expect(page).to have_content "Cancelado"
      expect(page).to have_content "N/A"
    end
  end
end