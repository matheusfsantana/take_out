class Tag < ApplicationRecord
  belongs_to :restaurant
  has_many :menu_item_tags
  has_many :menu_items, through: :menu_item_tags
  validates :name, presence: true
end
