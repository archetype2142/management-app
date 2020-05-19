class AddShipping < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string  :iso_name
      t.string  :iso
      t.string  :iso3
      t.string  :name
      t.integer :numcode
    end
    
    create_table :states do |t|
      t.string     :name
      t.string     :abbr
      t.references :country
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

    create_table :orders do |t|
      t.string     :number,                             limit: 15
      t.decimal    :item_total,                         precision: 8, scale: 2, default: 0.0, null: false
      t.decimal    :total,                              precision: 8, scale: 2, default: 0.0, null: false
      t.string     :state
      t.decimal    :adjustment_total,                   precision: 8, scale: 2, default: 0.0, null: false
      t.datetime   :completed_at
      t.references :bill_address
      t.references :ship_address
      t.decimal    :payment_total,                      precision: 8, scale: 2, default: 0.0
      t.references :shipping_method
      t.string     :shipment_state
      t.string     :payment_state
      t.string     :email
      t.text       :special_instructions
      t.timestamps null: false,                          precision: 6
    end

    add_index :orders, [:number], name: 'index_orders_on_number'

    create_table :shipping_methods do |t|
      t.string     :name
      t.string     :display_on
      t.references :shipping_category
      t.boolean    :match_none
      t.boolean    :match_all
      t.boolean    :match_one
      t.datetime   :deleted_at
      t.timestamps null: false,                           precision: 6
    end

    create_table :shipments do |t|
      t.string     :tracking
      t.string     :number
      t.decimal    :cost,                                 precision: 8, scale: 2
      t.datetime   :shipped_at
      t.references :order
      t.references :shipping_method
      t.references :address
      t.string     :state
      t.timestamps null: false,                           precision: 6
    end
  end
end
