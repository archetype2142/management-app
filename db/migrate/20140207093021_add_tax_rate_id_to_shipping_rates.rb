class AddTaxRateIdToShippingRates < ActiveRecord::Migration[4.2]
  def change
    add_column :shipping_rates, :tax_rate_id, :integer
  end
end
