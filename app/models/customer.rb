class Customer < ApplicationRecord
  belongs_to :restaurant
  before_validation :strip_cpf
  validate :cpf_must_be_valid
  validates :name, presence: true
  validate :phone_or_email_must_be_present

  def customer_description
    return "#{self.name} - #{self.phone_number}" if self.email && self.phone_number
    "#{self.name} - #{self.email}"
  end

  private
  def strip_cpf
    self.cpf = CPF.new(self.cpf).stripped if self.cpf
  end

  def phone_or_email_must_be_present
    if self.phone_number.blank? && self.email.blank?
      self.errors.add(:phone_number, 'Telefone ou E-mail precisa estar presente')
      self.errors.add(:email, 'Telefone ou E-mail precisa estar presente')   
    end
  end

  def cpf_must_be_valid
    if self.cpf.present?
      unless CPF.valid?(self.cpf)
        self.errors.add :cpf, "inválido"
      end
    end
  end

  def email_must_be_valid
    email_regex = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    unless self.email.match?(email_regex)
      self.errors.add :email, "inválido"
    end
  end
end
