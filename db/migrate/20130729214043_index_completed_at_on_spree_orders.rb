class IndexCompletedAtOnSpreeOrders < ActiveRecord::Migration[4.2]
  def change
    add_index :orders, :completed_at
  end
end
