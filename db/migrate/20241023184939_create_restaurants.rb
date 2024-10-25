class CreateRestaurants < ActiveRecord::Migration[7.2]
  def change
    create_table :restaurants do |t|
      t.string :corporate_name
      t.string :brand_name
      t.string :cnpj
      t.string :full_address
      t.string :phone_number
      t.string :email
      t.string :code
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
