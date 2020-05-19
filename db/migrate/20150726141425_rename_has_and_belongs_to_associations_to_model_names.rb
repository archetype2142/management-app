class RenameHasAndBelongsToAssociationsToModelNames < ActiveRecord::Migration[4.2]
  def change
    {
      'option_types_prototypes' => 'option_type_prototypes',
      'option_values_variants' => 'option_value_variants',
      'orders_promotions' => 'order_promotions',
      'products_promotion_rules' => 'product_promotion_rules',
      'taxons_promotion_rules' => 'promotion_rule_taxons',
      'promotion_rules_users' => 'promotion_rule_users',
      'properties_prototypes' => 'property_prototypes',
      'taxons_prototypes' => 'prototype_taxons',
      'roles_users' => 'role_users',
      'shipping_methods_zones' => 'shipping_method_zones'
    }.each do |old_name, new_name|
      rename_table old_name, new_name
    end
  end
end
