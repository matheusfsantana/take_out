class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :bussiness_hour

  validates :corporate_name, :brand_name, :cnpj, :full_address, :phone_number, :email, :code, presence: true
  validates :phone_number, length: {in: 10..11}
  validates :phone_number, numericality: { only_interger: true }
  validates :email, :cnpj, :user_id, uniqueness: true
  validate :cnpj_must_be_valid, :email_must_be_valid
  
  before_validation :strip_cnpj, :generate_code
  after_create :create_bussiness_hour

  private
  def create_bussiness_hour
    days_of_week = %w[Segunda Terça Quarta Quinta Sexta Sábado Domingo]
    days_of_week.each do |day|
      bussiness_hour.create(day_of_week: day, opening_hour: '00:00', closing_hour: '23:00', is_open: true)
    end
  end

  def generate_code 
    self.code = SecureRandom.alphanumeric(6).upcase
  end

  def strip_cnpj
    self.cnpj = CNPJ.new(self.cnpj).stripped
  end

  def cnpj_must_be_valid
    unless CNPJ.valid?(self.cnpj)
      self.errors.add :cnpj, "inválido"
    end
  end

  def email_must_be_valid
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    unless self.email.match?(email_regex)
      self.errors.add :email, "inválido"
    end
  end
end
