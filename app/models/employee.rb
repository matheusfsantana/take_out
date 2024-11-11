class Employee < ApplicationRecord
  belongs_to :restaurant
  validates :email, :cpf, presence: true
  validates :email, :cpf, uniqueness: true
  validate :email_must_be_unique, :email_must_be_valid, :cpf_must_be_unique, :cpf_must_be_valid
  before_create :set_default

  private
  def email_must_be_valid
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    if self.email.present?
      unless email_regex.match?(self.email)
        self.errors.add(:email, 'inválido')
      end
    end
  end

  def email_must_be_unique
   self.errors.add(:email, 'já está em uso') if User.exists?(email: self.email)
  end

  def cpf_must_be_valid
    if self.cpf.present?
      unless CPF.valid?(self.cpf)
        self.errors.add(:cpf, "inválido")
      end
    end
  end
  
  def cpf_must_be_unique
    self.errors.add(:cpf, 'já está em uso') if User.exists?(cpf: self.cpf)
  end
  
  def set_default
    self.is_registered = false
  end
end
