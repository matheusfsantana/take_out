class AddPriceToOrderItem < ActiveRecord::Migration[7.2]
  def change
    add_column :order_items, :price_at_order, :decimal
  end
end
