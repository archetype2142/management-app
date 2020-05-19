class AddPendingToInventoryUnit < ActiveRecord::Migration[4.2]
  def change
    add_column :inventory_units, :pending, :boolean, default: true
    InventoryUnit.update_all(pending: false)
  end
end
