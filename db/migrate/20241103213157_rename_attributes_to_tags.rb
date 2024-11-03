class RenameAttributesToTags < ActiveRecord::Migration[7.2]
  def change
    rename_table :attributes, :tags
  end
end
