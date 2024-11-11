class AddRestaurantToCustomer < ActiveRecord::Migration[7.2]
  def change
    add_reference :customers, :restaurant, null: false, foreign_key: true
  end
end
