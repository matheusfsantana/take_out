describe 'User sign in' do
  it 'with success' do
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
    expect(page).to have_content 'Login efetuado com sucesso.'
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