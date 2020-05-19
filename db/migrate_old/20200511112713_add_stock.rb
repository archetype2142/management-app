class AddStock < ActiveRecord::Migration[6.0]
  def change
    create_table :inventory_units do |t|
      t.integer    :lock_version,        default: 0
      t.string     :state
      t.references :variant
      t.references :order
      t.references :shipment
      t.references :return_authorization
      t.timestamps null: false, precision: 6
    end

    create_table :line_items do |t|
      t.references :variant
      t.references :order
      t.integer    :quantity,                         null: false
      t.decimal    :price,    precision: 8, scale: 2, null: false
      t.timestamps null: false, precision: 6
    end
  end
end
