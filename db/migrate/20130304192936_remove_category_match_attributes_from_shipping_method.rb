class RemoveCategoryMatchAttributesFromShippingMethod < ActiveRecord::Migration[4.2]
  def change
    remove_column :shipping_methods, :match_none
    remove_column :shipping_methods, :match_one
    remove_column :shipping_methods, :match_all
  end
end
