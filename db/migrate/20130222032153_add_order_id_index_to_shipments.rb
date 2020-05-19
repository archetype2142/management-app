class AddOrderIdIndexToShipments < ActiveRecord::Migration[4.2]
  def change
    add_index :shipments, :order_id
  end
end
