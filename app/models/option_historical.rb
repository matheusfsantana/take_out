class OptionHistorical < ApplicationRecord
  belongs_to :item_option

  validates :historical_price, :price_changed_at, presence: true
  validates :historical_price, comparison: { greater_than: 0 }
end
