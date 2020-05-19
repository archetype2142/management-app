class AddConsideredRiskyToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :considered_risky, :boolean, default: false
  end
end
