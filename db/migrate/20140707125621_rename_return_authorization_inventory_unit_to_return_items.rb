class RenameReturnAuthorizationInventoryUnitToReturnItems < ActiveRecord::Migration[4.2]
  def change
    rename_table :return_authorization_inventory_units, :return_items
  end
end
