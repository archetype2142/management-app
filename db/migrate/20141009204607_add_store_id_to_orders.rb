class AddStoreIdToOrders < ActiveRecord::Migration[4.2]
  def change
    # add_column :orders, :store_id, :integer
    # if Store.default.persisted?
    #   Order.where(store_id: nil).update_all(store_id: Store.default.id)
    # end
  end
end
