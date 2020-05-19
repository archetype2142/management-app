class AddIndexToSpreeStockItemsVariantId < ActiveRecord::Migration[4.2]
  def up
    unless index_exists? :stock_items, :variant_id
      add_index :stock_items, :variant_id
    end
  end

  def down
    if index_exists? :stock_items, :variant_id
      remove_index :stock_items, :variant_id
    end
  end
end
