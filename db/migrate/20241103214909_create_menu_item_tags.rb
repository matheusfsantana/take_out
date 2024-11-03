class CreateMenuItemTags < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_item_tags do |t|
      t.references :menu_item, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
