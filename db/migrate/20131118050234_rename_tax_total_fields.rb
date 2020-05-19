class RenameTaxTotalFields < ActiveRecord::Migration[4.2]
  def change
    rename_column :line_items, :tax_total, :additional_tax_total
    rename_column :shipments, :tax_total, :additional_tax_total
    rename_column :orders, :tax_total, :additional_tax_total

    add_column :line_items, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
    add_column :shipments, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
    add_column :orders, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
  end
end
