class AddMissingIndexesOnSpreeTables < ActiveRecord::Migration[4.2]
  def change
    if data_source_exists?(:promotion_rules_users) && !index_exists?(:promotion_rules_users,
                                                                     [:user_id, :promotion_rule_id],
                                                                     name: 'index_promotion_rules_users_on_user_id_and_promotion_rule_id')
      add_index :promotion_rules_users,
                [:user_id, :promotion_rule_id],
                name: 'index_promotion_rules_users_on_user_id_and_promotion_rule_id'
    end

    if data_source_exists?(:products_promotion_rules) && !index_exists?(:products_promotion_rules,
                                                                        [:promotion_rule_id, :product_id],
                                                                        name: 'index_products_promotion_rules_on_promotion_rule_and_product')
      add_index :products_promotion_rules,
                [:promotion_rule_id, :product_id],
                name: 'index_products_promotion_rules_on_promotion_rule_and_product'
    end

    unless index_exists? :orders, :canceler_id
      add_index :orders, :canceler_id
    end

    # unless index_exists? :orders, :store_id
      # add_index :orders, :store_id
    # end

    if data_source_exists?(:orders_promotions) && !index_exists?(:orders_promotions, [:promotion_id, :order_id])
      add_index :orders_promotions, [:promotion_id, :order_id]
    end

    if data_source_exists?(:properties_prototypes) && !index_exists?(:properties_prototypes, :prototype_id)
      add_index :properties_prototypes, :prototype_id
    end

    if data_source_exists?(:properties_prototypes) && !index_exists?(:properties_prototypes,
                                                                     [:prototype_id, :property_id],
                                                                     name: 'index_properties_prototypes_on_prototype_and_property')
      add_index :properties_prototypes,
                [:prototype_id, :property_id],
                name: 'index_properties_prototypes_on_prototype_and_property'
    end

    if data_source_exists?(:taxons_prototypes) && !index_exists?(:taxons_prototypes, [:prototype_id, :taxon_id])
      add_index :taxons_prototypes, [:prototype_id, :taxon_id]
    end

    if data_source_exists?(:option_types_prototypes) && !index_exists?(:option_types_prototypes, :prototype_id)
      add_index :option_types_prototypes, :prototype_id
    end

    if data_source_exists?(:option_types_prototypes) && !index_exists?(:option_types_prototypes,
                                                                       [:prototype_id, :option_type_id],
                                                                       name: 'index_option_types_prototypes_on_prototype_and_option_type')
      add_index :option_types_prototypes,
                [:prototype_id, :option_type_id],
                name: 'index_option_types_prototypes_on_prototype_and_option_type'
    end

    if data_source_exists?(:option_values_variants) && !index_exists?(:option_values_variants,
                                                                       [:option_value_id, :variant_id],
                                                                       name: 'index_option_values_variants_on_option_value_and_variant')
      add_index :option_values_variants,
                [:option_value_id, :variant_id],
                name: 'index_option_values_variants_on_option_value_and_variant'
    end
  end
end
