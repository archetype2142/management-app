class RemoveShippingMethodIdFromSpreeOrders < ActiveRecord::Migration[4.2]
  def up
    if column_exists?(:orders, :shipping_method_id, :integer)
      remove_column :orders, :shipping_method_id, :integer
    end
  end

  def down
    unless column_exists?(:orders, :shipping_method_id, :integer)
      add_column :orders, :shipping_method_id, :integer
    end
  end
end
