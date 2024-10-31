class CreateMenuItemOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_item_options do |t|
      t.string :description
      t.decimal :price
      t.references :menu_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
