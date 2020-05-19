class AddApproverIdAndApprovedAtToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :approver_id, :integer
    add_column :orders, :approved_at, :datetime
  end
end
