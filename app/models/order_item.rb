class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item_option
  validates :price_at_order, presence: true

  before_validation :set_price_at_order, if: :new_record?

  def description
    self.item_option.description
  end

  def price_at_order
    sprintf('%.2f', self[:price_at_order])
  end

  def observation
    return self[:observation] if self[:observation]
    "-"
  end
  
  private
  def set_price_at_order
    self.price_at_order = self.item_option.price
  end
end
