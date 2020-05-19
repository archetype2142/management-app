class AddManyMissingIndexes < ActiveRecord::Migration[4.2]
  def change
    add_index :adjustments, [:adjustable_id, :adjustable_type]
    add_index :adjustments, :eligible
    add_index :promotions, :code
    add_index :promotions, :expires_at
    add_index :states, :country_id
    add_index :stock_items, :deleted_at
    add_index :option_types, :position
    add_index :option_values, :position
    add_index :product_option_types, :option_type_id
    add_index :product_option_types, :product_id
    add_index :products_taxons, :position
    add_index :promotions, :starts_at
    add_index :stores, :url
  end
end
