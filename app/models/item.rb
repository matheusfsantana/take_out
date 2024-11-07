class Item < ApplicationRecord
  belongs_to :restaurant
  has_many :item_options, dependent: :destroy
  has_many :option_historical, through: :item_options
  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  has_many :menu_items
  has_many :menus, through: :menu_items
  has_one_attached :image
  validates :name, :description, presence: true
  validate :calories_must_be_positive, :image_format_need_to_be_valid

  private
  def calories_must_be_positive
    self.errors.add(:calories, 'não pode ser negativa') if self.calories.present? && self.calories < 0
  end

  def image_format_need_to_be_valid
    if self.image.present?
      unless ['.jpg', '.jpeg','.png'].include?(File.extname(image.filename.to_s).downcase)
        self.errors.add(:image, 'deve ser JPEG ou PNG')
      end
    end
  end
end

