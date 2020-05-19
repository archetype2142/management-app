class AddPromoTotalToLineItemsAndShipmentsAndOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :line_items, :promo_total, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :shipments, :promo_total, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :orders, :promo_total, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
