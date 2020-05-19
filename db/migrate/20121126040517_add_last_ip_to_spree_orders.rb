class AddLastIpToSpreeOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :last_ip_address, :string
  end
end
