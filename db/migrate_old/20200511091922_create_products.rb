class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_categories do |t|
      t.string   :name
      t.timestamps null: false,     precision: 6
    end

    create_table :tax_categories do |t|
      t.string     :name
      t.string     :description
      t.boolean    :is_default,     default: false
      t.datetime   :deleted_at
      t.timestamps null: false,     precision: 6
    end

    create_table :products do |t|
      t.string     :name,           default: '',            null: false
      t.text       :description
      t.datetime   :available_on
      t.datetime   :deleted_at
      t.string     :permalink
      t.string     :meta_description
      t.string     :meta_keywords
      t.references :tax_category
      t.references :shipping_category
      t.integer    :count_on_hand,  default: 0,              null: false
      t.timestamps null: false,     precision: 6
    end

    add_index :products, [:available_on], name: 'index_products_on_available_on'
    add_index :products, [:deleted_at],   name: 'index_products_on_deleted_at'
    add_index :products, [:name],         name: 'index_products_on_name'
    add_index :products, [:permalink],    name: 'index_products_on_permalink'

    create_table :variants do |t|
      t.string     :sku,           default: '',             null: false
      t.decimal    :price,         precision: 8, scale: 2,  null: false
      t.decimal    :weight,        precision: 8, scale: 2
      t.decimal    :height,        precision: 8, scale: 2
      t.decimal    :width,         precision: 8, scale: 2
      t.decimal    :depth,         precision: 8, scale: 2
      t.datetime   :deleted_at
      t.boolean    :is_master,     default: false
      t.references :product,       index: true
      t.integer    :count_on_hand, default: 0,              null: false
      t.decimal    :cost_price,    precision: 8, scale: 2
      t.integer    :position
    end
  end
end
