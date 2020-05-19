class SetDefaultStockLocationOnShipments < ActiveRecord::Migration[4.2]
  def change
    if Shipment.where('stock_location_id IS NULL').count > 0
      location = StockLocation.find_by(name: 'default') || StockLocation.first
      Shipment.where('stock_location_id IS NULL').update_all(stock_location_id: location.id)
    end
  end
end
