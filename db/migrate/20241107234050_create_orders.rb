class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.decimal :total
      t.integer :status, default: 0
      t.string :code
      t.datetime :order_date
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
