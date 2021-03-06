class CreateStockMovements < ActiveRecord::Migration[4.2]
  def change
    create_table :stock_movements do |t|
      t.belongs_to :stock_item
      t.integer :quantity
      t.string :action

      t.timestamps null: false, precision: 6
    end
    add_index :stock_movements, :stock_item_id
  end
end
