class AddCancelAuditFieldsToSpreeOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :canceled_at, :datetime
    add_column :orders, :canceler_id, :integer
  end
end
