require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid' do
    it 'false when name is empty' do
      user = User.new(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: '', last_name: 'da silva')

      expect(user.valid?).to be_falsy
      expect(user.errors.full_messages.first).to eq 'Nome não pode ficar em branco'
    end
    it 'false when last_name is empty' do
       user = User.new(email: 'teste@gmail.com', password: 'password1234', cpf: '00085364061', name: 'joaozinho', last_name: '')
      
      expect(user.valid?).to be_falsy
      expect(user.errors.full_messages.first).to eq 'Sobrenome não pode ficar em branco'
    end
    it 'false when cpf is empty' do
      user = User.new(email: 'teste@gmail.com', password: 'password1234', cpf: '', name: 'joaozinho', last_name: 'da silva')
      
      expect(user.valid?).to be_falsy
      expect(user.errors.full_messages.first).to eq 'CPF não pode ficar em branco'
    end
    it 'false when email is empty' do
      user = User.new(email: '', password: 'password1234', cpf: '00085364061', name: 'joaozinho', last_name: 'da silva')
      
      expect(user.valid?).to be_falsy
      expect(user.errors.full_messages.first).to eq 'E-mail não pode ficar em branco'
    end
    it 'false when password is empty' do
      user = User.new(email: 'teste@gmail.com', password: '', cpf: '00085364061', name: 'joaozinho', last_name: 'da silva')
      
      expect(user.valid?).to be_falsy
      expect(user.errors.full_messages.first).to eq 'Senha não pode ficar em branco'
    end
    it 'false when cpf is invalid' do
      user = User.new(email: 'teste@gmail.com', password: 'password1234', cpf: '12345678911', name: 'joaozinho', last_name: 'da silva')
      
      expect(user.valid?).to be_falsy
      expect(user.errors.full_messages.first).to eq 'CPF inválido'
    end
    it 'false when email is invalid' do
      first_user = User.new(email: 'teste@', password: 'password1234', cpf: '12345678911', name: 'joaozinho', last_name: 'da silva')
      second_user = User.new(email: 'teste@email', password: 'password1234', cpf: '12345678911', name: 'joaozinho', last_name: 'da silva')
      third_user = User.new(email: 'teste@gmail..com', password: 'password1234', cpf: '12345678911', name: 'joaozinho', last_name: 'da silva')

      expect(first_user.valid?).to be_falsy
      expect(second_user.valid?).to be_falsy
      expect(third_user.valid?).to be_falsy
      expect(first_user.errors.full_messages.first).to eq 'E-mail não é válido'
      expect(second_user.errors.full_messages.first).to eq 'E-mail não é válido'
      expect(third_user.errors.full_messages.first).to eq 'E-mail não é válido'

    end
    it 'false when password length is less than 12' do
      user = User.new(email: 'teste@gmail.com', password: '12345678910', cpf: '12345678911', name: 'joaozinho', last_name: 'da silva')

      expect(user.valid?).to be_falsy
      expect(user.errors.full_messages.first).to eq 'Senha é muito curta (mínimo: 12 caracteres)'

    end
    it 'false when email is not unique' do
      user = User.new(email: 'teste@gmail.com', password: 'password1234', cpf: '463.476.170-05', name: 'joaozinho', last_name: 'da silva')
      second_user = User.new(email: 'teste@gmail.com', password: 'password1234', cpf: '29389865050', name: 'joaozinho', last_name: 'da silva')

      user.save!

      expect(second_user.valid?).to be_falsy
      expect(second_user.errors.full_messages.first).to eq 'E-mail já está em uso'

    end
    it 'false when cpf is not unique' do
      user = User.new(email: 'abcd@gmail.com', password: 'password1234', cpf: '463.476.170-05', name: 'joaozinho', last_name: 'da silva')
      second_user = User.new(email: 'teste@gmail.com', password: 'password1234', cpf: '463.476.170-05', name: 'joaozinho', last_name: 'da silva')

      user.save!
      

      expect(second_user.valid?).to be_falsy
      expect(second_user.errors.full_messages.first).to eq 'CPF já está em uso'

    end
    it 'true when cpf is valid and all fields is filled' do
      user = User.new(email: 'teste@gmail.com', password: 'password1234', cpf: '463.476.170-05', name: 'joaozinho', last_name: 'da silva')

      expect(user.valid?).to be_truthy

    end
    it 'true when email is valid and all fields is filled' do
      user = User.new(email: 'teste@gmail.com', password: 'password1234', cpf: '463.476.170-05', name: 'joaozinho', last_name: 'da silva')

      expect(user.valid?).to be_truthy
    end
  end
  describe 'strip cpf' do
    it 'when create a new user' do
      first_user = User.new(email: 'valid_email@gmail.com', password: 'password1234', cpf: '29389865050', name: 'teste', last_name: 'da silva')
      second_user = User.new(email: 'test123@gmail.com', password: 'password1234', cpf: '463.476.170-05', name: 'teste', last_name: 'da silva')

      first_user.save!
      second_user.save!

      expect(first_user.cpf).to eq '29389865050'
      expect(second_user.cpf).to eq'46347617005'
    end
  end
end
