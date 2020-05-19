class AddOrderIdIndexToPayments < ActiveRecord::Migration[4.2]
  def self.up
    add_index :payments, :order_id
  end

  def self.down
    remove_index :payments, :order_id
  end
end
