class Menu < ApplicationRecord
  belongs_to :restaurant

  has_many :menu_items
  has_many :item, through: :menu_items
  validates :name, presence: true
  validate :check_if_name_exists


  private
  def check_if_name_exists
    if self.name.present? && Menu.find_by("restaurant_id = ? AND LOWER(name) = ?", self.restaurant_id, self.name.downcase)
      self.errors.add(:name, 'já existente para seu restaurante')
    end
  end
end
