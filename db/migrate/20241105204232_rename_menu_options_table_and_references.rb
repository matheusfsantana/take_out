class RenameMenuOptionsTableAndReferences < ActiveRecord::Migration[7.2]
  def change
    rename_table :menu_item_options, :item_options
    rename_column :item_options, :menu_item_id, :item_id
  end
end
