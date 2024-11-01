class MenuItemOption < ApplicationRecord
  belongs_to :menu_item
  has_many :option_historical, dependent: :destroy

  validates :description, :price, presence: true
  validates :price, comparison: { greater_than: 0 }

  before_update :save_option_historical

  def save_option_historical
    last_register = MenuItemOption.find_by(id: self.id)
    
    if last_register.present? && last_register.price != self.price
      option_historical.create(historical_price: last_register.price, price_changed_at: Time.zone.now)
    end
  end
end
