class AddIdColumnToEarlierHabtmTables < ActiveRecord::Migration[4.2]
  def up
    add_column :option_type_prototypes, :id, :primary_key
    add_column :option_value_variants, :id, :primary_key
    add_column :order_promotions, :id, :primary_key
    add_column :product_promotion_rules, :id, :primary_key
    add_column :promotion_rule_users, :id, :primary_key
    add_column :property_prototypes, :id, :primary_key
    add_column :role_users, :id, :primary_key
    add_column :shipping_method_zones, :id, :primary_key
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
