class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :description
      t.float :stock_level
      t.float :price

      t.timestamps
    end
  end
end
