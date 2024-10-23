class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :last_name, :cpf, presence: true
  validates :cpf, uniqueness: true
  validates_with CpfValidator
  
  before_validation :strip_cpf

  private
  def strip_cpf
    self.cpf = CPF.new(self.cpf).stripped
  end
end
