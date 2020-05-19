class AddItemCountToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :item_count, :integer, default: 0
  end
end
