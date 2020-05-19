class AddadditionalTax < ActiveRecord::Migration[6.0]
  def change
    add_column :line_items, :additional_tax_total, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :shipments, :additional_tax_total, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :orders, :additional_tax_total, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
