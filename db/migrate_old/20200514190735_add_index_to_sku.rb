class AddIndexToSku < ActiveRecord::Migration[6.0]
  def change
    add_index :variants, :sku
  end
end
