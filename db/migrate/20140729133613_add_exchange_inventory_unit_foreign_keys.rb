class AddExchangeInventoryUnitForeignKeys < ActiveRecord::Migration[4.2]
  def change
    add_column :return_items, :exchange_inventory_unit_id, :integer

    add_index :return_items, :exchange_inventory_unit_id
  end
end
