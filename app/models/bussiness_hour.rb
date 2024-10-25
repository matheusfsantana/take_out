class BussinessHour < ApplicationRecord
  belongs_to :restaurant
  validate :closing_hour_is_greater_than_opening, :closing_hour_is_mandatory_when_is_open, :opening_hour_is_mandatory_when_is_open

  private
  def closing_hour_is_greater_than_opening
    if self.closing_hour.present? && self.opening_hour.present? && self.closing_hour < self.opening_hour
      self.errors.add(:closing_hour, 'deve ser maior que horário de abertura')
    end
  end

  def opening_hour_is_mandatory_when_is_open
    if self.is_open && !self.opening_hour.present? 
      self.errors.add(:opening_hour, 'é obrigatório quando o estabelecimento está aberto')
    end
  end

  def closing_hour_is_mandatory_when_is_open
    if self.is_open && !self.closing_hour.present? 
      self.errors.add(:closing_hour, 'é obrigatório quando o estabelecimento está aberto')
    end
  end
end
