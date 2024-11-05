class RenameOptionHistoricalsMenuItemOptionIdColumn < ActiveRecord::Migration[7.2]
  def change
    rename_column :option_historicals, :menu_item_option_id, :item_option_id
  end
end
