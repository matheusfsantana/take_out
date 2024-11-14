class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item_option
  validates :price_at_order, presence: true

  before_validation :set_price_at_order, if: :new_record?
  before_validation :set_observation

  def description
    self.item_option.description
  end

  def price_at_order
    sprintf('%.2f', self[:price_at_order])
  end

  private
  def set_price_at_order
    self.price_at_order = self.item_option.price
  end

  def set_observation
    self.observation ||= '-'
  end
end
