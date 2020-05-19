class ChangeOrdersTotalPrecision < ActiveRecord::Migration[4.2]
   def change
    change_column :orders, :item_total,  :decimal, precision: 10, scale: 2, default: 0.0, null: false
    change_column :orders, :total,  :decimal, precision: 10, scale: 2, default: 0.0, null: false
    change_column :orders, :adjustment_total,  :decimal, precision: 10, scale: 2, default: 0.0, null: false
    change_column :orders, :payment_total,  :decimal, precision: 10, scale: 2, default: 0.0                                
   end
end
