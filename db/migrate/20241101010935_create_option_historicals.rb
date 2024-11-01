class CreateOptionHistoricals < ActiveRecord::Migration[7.2]
  def change
    create_table :option_historicals do |t|
      t.decimal :historical_price
      t.datetime :price_changed_at
      t.references :menu_item_option, null: false, foreign_key: true

      t.timestamps
    end
  end
end
