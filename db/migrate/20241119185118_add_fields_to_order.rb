class AddFieldsToOrder < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :canceled_reason, :text
    add_column :orders, :canceled_date, :datetime
    add_column :orders, :in_preparation_date, :datetime
    add_column :orders, :ready_date, :datetime
    add_column :orders, :delivered_date, :datetime
  end
end
