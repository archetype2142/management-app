class AddIndexes < ActiveRecord::Migration[4.2]
  def change
    add_index :assets, :position
    add_index :option_types, :name
    add_index :option_values, :name
    add_index :prices, :variant_id
    add_index :properties, :name
    add_index :roles, :name
    add_index :shipping_categories, :name
    add_index :taxons, :lft
    add_index :taxons, :rgt
    add_index :taxons, :name
  end
end
