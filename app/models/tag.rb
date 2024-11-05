class Tag < ApplicationRecord
  belongs_to :restaurant
  has_many :item_tags
  has_many :items, through: :item_tags
  validates :name, presence: true
end
