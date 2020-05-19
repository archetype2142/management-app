class AddBackorderableToStockItem < ActiveRecord::Migration[4.2]
  def change
    add_column :stock_items, :backorderable, :boolean, default: true
  end
end
