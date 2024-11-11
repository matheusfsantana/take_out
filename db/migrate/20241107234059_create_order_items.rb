class CreateOrderItems < ActiveRecord::Migration[7.2]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :item_option, null: false, foreign_key: true
      t.string :observation

      t.timestamps
    end
  end
end
