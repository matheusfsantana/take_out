class ChangeForeignKeyForRestaurantInUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :restaurants, :user_id, :integer
    add_reference :users, :restaurant, null: true, foreign_key: true
  end
end
