class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item_option
  validates :price_at_order, presence: true

  before_validation :set_price_at_order, if: :new_record?

  private
  def set_price_at_order
    self.price_at_order = self.item_option.price
  end
end
