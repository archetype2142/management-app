class AddTaxTotalFields < ActiveRecord::Migration[6.0]
  def change
    add_column :line_items, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
    add_column :shipments, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
    add_column :orders, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
  end
end
