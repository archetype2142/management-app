class AddSkuIndexToSpreeVariants < ActiveRecord::Migration[4.2]
  def change
    add_index :variants, :sku
  end
end
