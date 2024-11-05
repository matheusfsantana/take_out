class RenameMenuItemTable < ActiveRecord::Migration[7.2]
  def change
    rename_table :menu_items, :items
  end
end
