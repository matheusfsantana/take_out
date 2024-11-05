class RenameMenuTagsTableAndReferences < ActiveRecord::Migration[7.2]
  def change
    rename_table :menu_item_tags, :item_tags
    rename_column :item_tags, :menu_item_id, :item_id
  end
end
