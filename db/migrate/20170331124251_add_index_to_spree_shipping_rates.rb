class AddIndexToSpreeShippingRates < ActiveRecord::Migration[5.0]
  def change
    add_index :shipping_rates, :shipment_id
    add_index :shipping_rates, :shipping_method_id
  end
end
