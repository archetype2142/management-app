class AddDefaultQuantityToStockMovement < ActiveRecord::Migration[4.2]
  def change
    change_column :stock_movements, :quantity, :integer, default: 0
  end
end
