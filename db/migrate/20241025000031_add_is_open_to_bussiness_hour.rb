class AddIsOpenToBussinessHour < ActiveRecord::Migration[7.2]
  def change
    add_column :bussiness_hours, :is_open, :boolean, default: false, null: false
  end
end
