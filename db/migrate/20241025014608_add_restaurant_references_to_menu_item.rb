class AddRestaurantReferencesToMenuItem < ActiveRecord::Migration[7.2]
  def change
    add_reference :menu_items, :restaurant, null: false, foreign_key: true
  end
end
