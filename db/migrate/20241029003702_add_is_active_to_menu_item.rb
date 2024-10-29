class AddIsActiveToMenuItem < ActiveRecord::Migration[7.2]
  def change
    add_column :menu_items, :is_active, :boolean, default: true, null: false
  end
end
