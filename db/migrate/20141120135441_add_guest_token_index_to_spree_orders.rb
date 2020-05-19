class AddGuestTokenIndexToSpreeOrders < ActiveRecord::Migration[4.2]
  def change
    add_index :orders, :guest_token
  end
end
