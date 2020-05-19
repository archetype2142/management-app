class RenameAdjustmentFields < ActiveRecord::Migration[4.2]
  def up
    # Add Temporary index
    add_index :adjustments, :adjustable_type unless index_exists?(:adjustments, :adjustable_type)

    remove_column :adjustments, :originator_id
    remove_column :adjustments, :originator_type

    add_column :adjustments, :order_id, :integer unless column_exists?(:adjustments, :order_id)

    # This enables the Order#all_adjustments association to work correctly
    Adjustment.reset_column_information
    Adjustment.where(adjustable_type: "Order").find_each do |adjustment|
      adjustment.update_column(:order_id, adjustment.adjustable_id)
    end

    # Remove Temporary index
    remove_index :adjustments, :adjustable_type if index_exists?(:adjustments, :adjustable_type)
  end
end
