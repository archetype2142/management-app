class AddStockLocationIdToSpreeShipments < ActiveRecord::Migration[4.2]
  def change
    add_column :shipments, :stock_location_id, :integer
  end
end
