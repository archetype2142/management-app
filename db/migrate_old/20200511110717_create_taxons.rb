class CreateTaxons < ActiveRecord::Migration[6.0]
  def change
    create_table :spree_taxonomies do |t|
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

    create_table :products_taxons, id: false do |t|
      t.references :product
      t.references :taxon
    end
  end
end
