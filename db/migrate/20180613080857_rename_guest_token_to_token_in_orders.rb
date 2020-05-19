class RenameGuestTokenToTokenInOrders < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :guest_token, :token
  end
end
