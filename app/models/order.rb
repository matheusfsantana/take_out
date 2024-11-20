class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :restaurant
  has_many :order_items
  has_many :items, through: :order_items
  has_many :item_options, through: :order_items
  
  validates :status, :order_date, presence: true
  accepts_nested_attributes_for :order_items, allow_destroy: true, reject_if: :all_blank
  
  enum :status, {:pending_confirmation=>0, :pending_kitchen=>5, :in_preparation=>10, :canceled=>15, :ready=>20, :delivered=>25}  
  before_validation :calculate_total, :reason_must_be_present_if_canceled
  before_validation :set_default, :generate_random_code, on: :create
  before_validation :fill_date_when_change_status, on: :update
  validate :must_have_at_least_one_order_item
  
  def total
    sprintf('%.2f', self[:total])
  end
  
  private
  def fill_date_when_change_status
    self.in_preparation_date = Time.zone.now if self.pending_kitchen?
    self.ready_date = Time.zone.now if self.ready?
    self.delivered_date = Time.zone.now if self.delivered?
    self.canceled_date = Time.zone.now if self.canceled?
  end

  def reason_must_be_present_if_canceled
    errors.add(:canceled_reason, "deve ser especificada caso cancele o pedido") if self.canceled? && self.canceled_reason.blank?
  end

  def calculate_total
    self.total = self.order_items.sum { |item| item.item_option&.price}
  end
  
  def generate_random_code
    self.code = SecureRandom.alphanumeric(8).upcase
  end

  def set_default
    self.status = :pending_confirmation 
    self.order_date = Time.zone.now  
  end
  
  def must_have_at_least_one_order_item
    if order_items.empty? 
      errors.add(:order_item, "deve conter pelo menos um item.")
    end
  end
end
