describe 'User sign in' do
  it 'with success and hasnt a restaurant' do
    User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')

    visit root_path
    within('form') do
      fill_in 'E-mail', with: 'teste@gmail.com'
      fill_in 'Senha', with: 'password1234'
      click_on 'Entrar'
    end

    within('nav') do
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Teste'
    end
    expect(current_path).to eq new_restaurant_path
    expect(page).to have_content 'É necessário registrar seu restaurante antes de prosseguir'

  end
  it 'with success and has a restaurant' do
    user = User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')
    Restaurant.create!(corporate_name: 'hot lanches xyz', brand_name: 'hot lanches', cnpj: '84685592000112',
                      full_address:'Rua da Hot, 721 - RJ',email:'contato@hotlanches.com', phone_number: '81987654321', user: user)
    visit root_path
    within('form') do
      fill_in 'E-mail', with: 'teste@gmail.com'
      fill_in 'Senha', with: 'password1234'
      click_on 'Entrar'
    end

    within('nav') do
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Teste'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
    expect(current_path).to eq root_path
  end
  it 'and sign out' do
    User.create!(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'teste', last_name: 'da silva')

    visit root_path
    within('form') do
      fill_in 'E-mail', with: 'teste@gmail.com'
      fill_in 'Senha', with: 'password1234'
      click_on 'Entrar'
    end

    click_on 'Sair'
    expect(page).to have_content 'Para continuar, faça login ou registre-se.'
    within('nav') do
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_content 'teste@gmail.com'
    end
  end
end