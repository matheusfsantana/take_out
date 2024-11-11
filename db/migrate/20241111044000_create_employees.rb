class CreateEmployees < ActiveRecord::Migration[7.2]
  def change
    create_table :employees do |t|
      t.string :email
      t.string :cpf
      t.boolean :is_registered
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
