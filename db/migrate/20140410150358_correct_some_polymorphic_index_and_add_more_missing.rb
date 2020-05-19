class CorrectSomePolymorphicIndexAndAddMoreMissing < ActiveRecord::Migration[4.2]
  def change
    add_index :addresses, :country_id
    add_index :addresses, :state_id
    remove_index :adjustments, [:source_type, :source_id]
    add_index :adjustments, [:source_id, :source_type]
    add_index :credit_cards, :address_id
    add_index :gateways, :active
    add_index :gateways, :test_mode
    add_index :inventory_units, :return_authorization_id
    add_index :line_items, :tax_category_id
    add_index :log_entries, [:source_id, :source_type]
    add_index :orders, :approver_id
    add_index :orders, :bill_address_id
    add_index :orders, :confirmation_delivered
    add_index :orders, :considered_risky
    add_index :orders, :created_by_id
    add_index :orders, :ship_address_id
    add_index :orders, :shipping_method_id
    add_index :orders_promotions, [:order_id, :promotion_id]
    add_index :payments, [:source_id, :source_type]
    add_index :prices, :deleted_at
    add_index :product_option_types, :position
    add_index :product_properties, :position
    add_index :product_properties, :property_id
    add_index :products, :shipping_category_id
    add_index :products, :tax_category_id
    add_index :promotion_action_line_items, :promotion_action_id
    add_index :promotion_action_line_items, :variant_id
    add_index :promotion_rules, :promotion_id
    add_index :promotions, :advertise
    add_index :return_authorizations, :number
    add_index :return_authorizations, :order_id
    add_index :return_authorizations, :stock_location_id
    add_index :shipments, :address_id
    add_index :shipping_methods, :deleted_at
    add_index :shipping_methods, :tax_category_id
    add_index :shipping_rates, :selected
    add_index :shipping_rates, :tax_rate_id
    add_index :state_changes, [:stateful_id, :stateful_type]
    add_index :state_changes, :user_id
    add_index :stock_items, :backorderable
    add_index :stock_locations, :active
    add_index :stock_locations, :backorderable_default
    add_index :stock_locations, :country_id
    add_index :stock_locations, :propagate_all_variants
    add_index :stock_locations, :state_id
    add_index :tax_categories, :deleted_at
    add_index :tax_categories, :is_default
    add_index :tax_rates, :deleted_at
    add_index :tax_rates, :included_in_price
    add_index :tax_rates, :show_rate_in_label
    add_index :tax_rates, :tax_category_id
    add_index :tax_rates, :zone_id
    add_index :taxonomies, :position
    add_index :taxons, :position
    add_index :trackers, :active
    add_index :variants, :deleted_at
    add_index :variants, :is_master
    add_index :variants, :position
    add_index :variants, :track_inventory
    add_index :zone_members, :zone_id
    add_index :zone_members, [:zoneable_id, :zoneable_type]
    add_index :zones, :default_tax
  end
end
