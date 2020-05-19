class AddConfirmationDeliveredToSpreeOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :confirmation_delivered, :boolean, default: false
  end
end
