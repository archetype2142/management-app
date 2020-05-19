class AddCreatedByIdToSpreeOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :created_by_id, :integer
  end
end
