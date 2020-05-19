class AddVariantIndexOnPrices < ActiveRecord::Migration[6.0]
  def change
    add_index :prices, [:variant_id, :currency]
  end
end
