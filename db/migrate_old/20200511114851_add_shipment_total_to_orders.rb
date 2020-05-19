class AddShipmentTotalToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :shipment_total, :decimal, precision: 10, scale: 2, default: 0.0, null: false
  end
end
