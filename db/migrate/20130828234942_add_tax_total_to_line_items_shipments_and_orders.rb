class AddTaxTotalToLineItemsShipmentsAndOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :line_items, :tax_total, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :shipments, :tax_total, :decimal, precision: 10, scale: 2, default: 0.0
    # This column may already be here from a 2.1.x migration
    add_column :orders, :tax_total, :decimal, precision: 10, scale: 2, default: 0.0 unless column_exists? :orders, :tax_total, :decimal
  end
end
