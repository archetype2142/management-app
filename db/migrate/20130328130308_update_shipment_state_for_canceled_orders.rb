class UpdateShipmentStateForCanceledOrders < ActiveRecord::Migration[4.2]
  def up
    shipments = Shipment.joins(:order).
      where("orders.state = 'canceled'")
    case Shipment.connection.adapter_name
    when "SQLite3"
      shipments.update_all("state = 'cancelled'")
    when "MySQL" || "PostgreSQL"
      shipments.update_all("shipments.state = 'cancelled'")
    end
  end

  def down
  end
end
