class AddIndexesToReturnAuthorizations < ActiveRecord::Migration[5.0]
  def change
    add_index :return_authorizations, :order_id
    add_index :return_authorizations, :stock_location_id
  end
end
