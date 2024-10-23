class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :last_name, :cpf, presence: true
  validates :cpf, uniqueness: true
  validate :cpf_must_be_valid

  before_validation :strip_cpf

  private
  def strip_cpf
    self.cpf = CPF.new(self.cpf).stripped
  end

  def cpf_must_be_valid
    unless CPF.valid?(self.cpf)
      self.errors.add :cpf, "inválido"
    end
  end
end
