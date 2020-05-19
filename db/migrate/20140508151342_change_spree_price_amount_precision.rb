class ChangeSpreePriceAmountPrecision < ActiveRecord::Migration[4.2]
  def change
    change_column :prices, :amount,  :decimal, precision: 10, scale: 2
    change_column :line_items, :price,  :decimal, precision: 10, scale: 2
    change_column :line_items, :cost_price,  :decimal, precision: 10, scale: 2
    change_column :variants, :cost_price, :decimal, precision: 10, scale: 2
  end
end
