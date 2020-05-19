class OneTwo < ActiveRecord::Migration[4.2]
  def up
    # This migration is just a compressed version of all the previous
    # migrations for core. Do not run it if one of the core tables
    # already exists. Assume the best.
    return if data_source_exists?(:addresses)


    create_table :activators do |t|
      t.string     :description
      t.datetime   :expires_at
      t.datetime   :starts_at
      t.string     :name
      t.string     :event_name
      t.string     :type
      t.integer    :usage_limit
      t.string     :match_policy, default: 'all'
      t.string     :code
      t.boolean    :advertise,    default: false
      t.string     :path
      t.timestamps null: false, precision: 6
    end

    create_table :addresses do |t|
      t.string     :firstname
      t.string     :lastname
      t.string     :address1
      t.string     :address2
      t.string     :city
      t.string     :zipcode
      t.string     :phone
      t.string     :state_name
      t.string     :alternative_phone
      t.string     :company
      t.references :state
      t.references :country
      t.timestamps null: false, precision: 6
    end

    add_index :addresses, [:firstname], name: 'index_addresses_on_firstname'
    add_index :addresses, [:lastname],  name: 'index_addresses_on_lastname'

    create_table :adjustments do |t|
      t.references :source,     polymorphic: true
      t.references :adjustable, polymorphic: true
      t.references :originator, polymorphic: true
      t.decimal    :amount,     precision: 8, scale: 2
      t.string     :label
      t.boolean    :mandatory
      t.boolean    :locked
      t.boolean    :eligible,   default: true
      t.timestamps null: false, precision: 6
    end

    add_index :adjustments, [:adjustable_id], name: 'index_adjustments_on_order_id'

    create_table :assets do |t|
      t.references :viewable,               polymorphic: true
      t.integer    :attachment_width
      t.integer    :attachment_height
      t.integer    :attachment_file_size
      t.integer    :position
      t.string     :attachment_content_type
      t.string     :attachment_file_name
      t.string     :type,                   limit: 75
      t.datetime   :attachment_updated_at
      t.text       :alt
    end

    add_index :assets, [:viewable_id],          name: 'index_assets_on_viewable_id'
    add_index :assets, [:viewable_type, :type], name: 'index_assets_on_viewable_type_and_type'

    create_table :calculators do |t|
      t.string     :type
      t.references :calculable, polymorphic: true
      t.timestamps null: false, precision: 6
    end

    create_table :configurations do |t|
      t.string     :name
      t.string     :type, limit: 50
      t.timestamps null: false, precision: 6
    end

    add_index :configurations, [:name, :type], name: 'index_configurations_on_name_and_type'

    create_table :countries do |t|
      t.string  :iso_name
      t.string  :iso
      t.string  :iso3
      t.string  :name
      t.integer :numcode
    end

    create_table :credit_cards do |t|
      t.string     :month
      t.string     :year
      t.string     :cc_type
      t.string     :last_digits
      t.string     :first_name
      t.string     :last_name
      t.string     :start_month
      t.string     :start_year
      t.string     :issue_number
      t.references :address
      t.string     :gateway_customer_profile_id
      t.string     :gateway_payment_profile_id
      t.timestamps null: false, precision: 6
    end

    create_table :gateways do |t|
      t.string     :type
      t.string     :name
      t.text       :description
      t.boolean    :active,      default: true
      t.string     :environment, default: 'development'
      t.string     :server,      default: 'test'
      t.boolean    :test_mode,   default: true
      t.timestamps null: false, precision: 6
    end

    create_table :inventory_units do |t|
      t.integer    :lock_version,        default: 0
      t.string     :state
      t.references :variant
      t.references :order
      t.references :shipment
      t.references :return_authorization
      t.timestamps null: false, precision: 6
    end

    add_index :inventory_units, [:order_id],    name: 'index_inventory_units_on_order_id'
    add_index :inventory_units, [:shipment_id], name: 'index_inventory_units_on_shipment_id'
    add_index :inventory_units, [:variant_id],  name: 'index_inventory_units_on_variant_id'

    create_table :line_items do |t|
      t.references :variant
      t.references :order
      t.integer    :quantity,                               null: false
      t.decimal    :price,    precision: 8, scale: 2, null: false
      t.timestamps null: false, precision: 6
    end

    add_index :line_items, [:order_id],   name: 'index_line_items_on_order_id'
    add_index :line_items, [:variant_id], name: 'index_line_items_on_variant_id'

    create_table :log_entries do |t|
      t.references :source, polymorphic: true
      t.text     :details
      t.timestamps null: false, precision: 6
    end

    create_table :mail_methods do |t|
      t.string     :environment
      t.boolean    :active,     default: true
      t.timestamps null: false, precision: 6
    end

    create_table :option_types do |t|
      t.string    :name,         limit: 100
      t.string    :presentation, limit: 100
      t.integer   :position,                   default: 0, null: false
      t.timestamps null: false, precision: 6
    end

    create_table :option_types_prototypes, id: false do |t|
      t.references :prototype
      t.references :option_type
    end

    create_table :option_values do |t|
      t.integer    :position
      t.string     :name
      t.string     :presentation
      t.references :option_type
      t.timestamps null: false, precision: 6
    end

    create_table :option_values_variants, id: false do |t|
      t.references :variant
      t.references :option_value
    end

    add_index :option_values_variants, [:variant_id, :option_value_id], name: 'index_option_values_variants_on_variant_id_and_option_value_id'
    add_index :option_values_variants, [:variant_id],                   name: 'index_option_values_variants_on_variant_id'

    create_table :orders do |t|
      t.string     :number,               limit: 15
      t.decimal    :item_total,                         precision: 8, scale: 2, default: 0.0, null: false
      t.decimal    :total,                              precision: 8, scale: 2, default: 0.0, null: false
      t.string     :state
      t.decimal    :adjustment_total,                   precision: 8, scale: 2, default: 0.0, null: false
      t.references :user
      t.datetime   :completed_at
      t.references :bill_address
      t.references :ship_address
      t.decimal    :payment_total,                      precision: 8, scale: 2, default: 0.0
      t.references :shipping_method
      t.string     :shipment_state
      t.string     :payment_state
      t.string     :email
      t.text       :special_instructions
      t.timestamps null: false, precision: 6
    end

    add_index :orders, [:number], name: 'index_orders_on_number'

    create_table :payment_methods do |t|
      t.string     :type
      t.string     :name
      t.text       :description
      t.boolean    :active,      default: true
      t.string     :environment, default: 'development'
      t.datetime   :deleted_at
      t.string     :display_on
      t.timestamps null: false, precision: 6
    end

    create_table :payments do |t|
      t.decimal    :amount, precision: 8, scale: 2, default: 0.0, null: false
      t.references :order
      t.references :source, polymorphic: true
      t.references :payment_method
      t.string     :state
      t.string     :response_code
      t.string     :avs_response
      t.timestamps null: false, precision: 6
    end

    create_table :preferences do |t|
      t.string     :name, limit: 100
      t.references :owner, polymorphic: true
      t.text       :value
      t.string     :key
      t.string     :value_type
      t.timestamps null: false, precision: 6
    end

    add_index :preferences, [:key], name: 'index_preferences_on_key', unique: true

    create_table :product_option_types do |t|
      t.integer    :position
      t.references :product
      t.references :option_type
      t.timestamps null: false, precision: 6
    end

    create_table :product_properties do |t|
      t.string     :value
      t.references :product
      t.references :property
      t.timestamps null: false, precision: 6
    end

    add_index :product_properties, [:product_id], name: 'index_product_properties_on_product_id'

    create_table :products do |t|
      t.string     :name,                 default: '', null: false
      t.text       :description
      t.datetime   :available_on
      t.datetime   :deleted_at
      t.string     :permalink
      t.string     :meta_description
      t.string     :meta_keywords
      t.references :tax_category
      t.references :shipping_category
      t.integer    :count_on_hand,        default: 0,  null: false
      t.timestamps null: false, precision: 6
    end

    add_index :products, [:available_on], name: 'index_products_on_available_on'
    add_index :products, [:deleted_at],   name: 'index_products_on_deleted_at'
    add_index :products, [:name],         name: 'index_products_on_name'
    add_index :products, [:permalink],    name: 'index_products_on_permalink'

    create_table :products_taxons, id: false do |t|
      t.references :product
      t.references :taxon
    end

    add_index :products_taxons, [:product_id], name: 'index_products_taxons_on_product_id'
    add_index :products_taxons, [:taxon_id],   name: 'index_products_taxons_on_taxon_id'

    create_table :properties do |t|
      t.string     :name
      t.string     :presentation, null: false
      t.timestamps null: false, precision: 6
    end

    create_table :properties_prototypes, id: false do |t|
      t.references :prototype
      t.references :property
    end

    create_table :prototypes do |t|
      t.string     :name
      t.timestamps null: false, precision: 6
    end

    create_table :return_authorizations do |t|
      t.string     :number
      t.string     :state
      t.decimal    :amount, precision: 8, scale: 2, default: 0.0, null: false
      t.references :order
      t.text       :reason
      t.timestamps null: false, precision: 6
    end

    create_table :roles do |t|
      t.string :name
    end

    create_table :roles_users, id: false do |t|
      t.references :role
      t.references :user
    end

    add_index :roles_users, [:role_id], name: 'index_roles_users_on_role_id'
    add_index :roles_users, [:user_id], name: 'index_roles_users_on_user_id'

    create_table :shipments do |t|
      t.string     :tracking
      t.string     :number
      t.decimal    :cost,           precision: 8, scale: 2
      t.datetime   :shipped_at
      t.references :order
      t.references :shipping_method
      t.references :address
      t.string     :state
      t.timestamps null: false, precision: 6
    end

    add_index :shipments, [:number], name: 'index_shipments_on_number'

    create_table :shipping_categories do |t|
      t.string   :name
      t.timestamps null: false, precision: 6
    end

    create_table :shipping_methods do |t|
      t.string     :name
      t.references :zone
      t.string     :display_on
      t.references :shipping_category
      t.boolean    :match_none
      t.boolean    :match_all
      t.boolean    :match_one
      t.datetime   :deleted_at
      t.timestamps null: false, precision: 6
    end

    create_table :state_changes do |t|
      t.string     :name
      t.string     :previous_state
      t.references :stateful
      t.references :user
      t.string     :stateful_type
      t.string     :next_state
      t.timestamps null: false, precision: 6
    end

    create_table :states do |t|
      t.string     :name
      t.string     :abbr
      t.references :country
    end

    create_table :tax_categories do |t|
      t.string     :name
      t.string     :description
      t.boolean    :is_default, default: false
      t.datetime   :deleted_at
      t.timestamps null: false, precision: 6
    end

    create_table :tax_rates do |t|
      t.decimal    :amount,            precision: 8, scale: 5
      t.references :zone
      t.references :tax_category
      t.boolean    :included_in_price, default: false
      t.timestamps null: false, precision: 6
    end

    create_table :taxonomies do |t|
      t.string     :name, null: false
      t.timestamps null: false, precision: 6
    end

    create_table :taxons do |t|
      t.references :parent
      t.integer    :position,          default: 0
      t.string     :name,                             null: false
      t.string     :permalink
      t.references :taxonomy
      t.integer    :lft
      t.integer    :rgt
      t.string     :icon_file_name
      t.string     :icon_content_type
      t.integer    :icon_file_size
      t.datetime   :icon_updated_at
      t.text       :description
      t.timestamps null: false, precision: 6
    end

    add_index :taxons, [:parent_id],   name: 'index_taxons_on_parent_id'
    add_index :taxons, [:permalink],   name: 'index_taxons_on_permalink'
    add_index :taxons, [:taxonomy_id], name: 'index_taxons_on_taxonomy_id'

    create_table :tokenized_permissions, force: true do |t|
      t.references :permissable, polymorphic: true
      t.string     :token
      t.timestamps null: false, precision: 6
    end

    add_index :tokenized_permissions, [:permissable_id, :permissable_type], name: 'index_tokenized_name_and_type'

    create_table :trackers do |t|
      t.string     :environment
      t.string     :analytics_id
      t.boolean    :active,       default: true
      t.timestamps null: false, precision: 6
    end

    create_table :users do |t|
      t.string     :encrypted_password,     limit: 128
      t.string     :password_salt,          limit: 128
      t.string     :email
      t.string     :remember_token
      t.string     :persistence_token
      t.string     :reset_password_token
      t.string     :perishable_token
      t.integer    :sign_in_count,                         default: 0, null: false
      t.integer    :failed_attempts,                       default: 0, null: false
      t.datetime   :last_request_at
      t.datetime   :current_sign_in_at
      t.datetime   :last_sign_in_at
      t.string     :current_sign_in_ip
      t.string     :last_sign_in_ip
      t.string     :login
      t.references :ship_address
      t.references :bill_address
      t.string     :authentication_token
      t.string     :unlock_token
      t.datetime   :locked_at
      t.datetime   :remember_created_at
      t.timestamps null: false, precision: 6
      t.string :provider, null: false, default: "email"
      t.string :uid, null: false, default: ""
      t.datetime :reset_password_sent_at
      t.boolean  :allow_password_change, default: false
      t.string :nickname
      t.string :image

      ## Tokens
      t.json :tokens
    end

    add_index :users, :email,                unique: true
    add_index :users, [:uid, :provider],     unique: true


    create_table :variants do |t|
      t.string     :sku,                                         default: '',    null: false
      t.decimal    :price,         precision: 8, scale: 2,                    null: false
      t.decimal    :weight,        precision: 8, scale: 2
      t.decimal    :height,        precision: 8, scale: 2
      t.decimal    :width,         precision: 8, scale: 2
      t.decimal    :depth,         precision: 8, scale: 2
      t.datetime   :deleted_at
      t.boolean    :is_master,                                   default: false
      t.references :product
      t.integer    :count_on_hand,                               default: 0,     null: false
      t.decimal    :cost_price,    precision: 8, scale: 2
      t.integer    :position
    end

    add_index :variants, [:product_id], name: 'index_variants_on_product_id'

    create_table :zone_members do |t|
      t.references :zoneable, polymorphic: true
      t.references :zone
      t.timestamps null: false, precision: 6
    end

    create_table :zones do |t|
      t.string     :name
      t.string     :description
      t.boolean    :default_tax,        default: false
      t.integer    :zone_members_count, default: 0
      t.timestamps null: false, precision: 6
    end
  end
end
