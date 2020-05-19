class DefaultPreTaxAmountShouldBeZero < ActiveRecord::Migration[4.2]
  def change
    change_column :line_items, :pre_tax_amount, :decimal, precision: 8, scale: 2, default: 0
    change_column :shipments, :pre_tax_amount, :decimal, precision: 8, scale: 2, default: 0
  end
end
