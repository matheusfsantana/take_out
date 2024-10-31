class MenuItemOption < ApplicationRecord
  belongs_to :menu_item

  validates :description, :price, presence: true
  validates :price, comparison: { greater_than: 0 }
end
