class CreateMenuItems < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_items do |t|
      t.string :type
      t.string :name
      t.string :description
      t.integer :calories
      t.boolean :alcoholic

      t.timestamps
    end
  end
end
