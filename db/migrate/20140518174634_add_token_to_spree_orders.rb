class AddTokenToSpreeOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :guest_token, :string
  end
end
