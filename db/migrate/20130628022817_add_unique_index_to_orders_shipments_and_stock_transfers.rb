class AddUniqueIndexToOrdersShipmentsAndStockTransfers < ActiveRecord::Migration[4.2]
  def add
    add_index "orders", ["number"], name: "number_idx_unique", unique: true
    add_index "shipments", ["number"], name: "number_idx_unique", unique: true
    add_index "stock_transfers", ["number"], name: "number_idx_unique", unique: true
  end
end
