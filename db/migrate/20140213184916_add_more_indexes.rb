class AddMoreIndexes < ActiveRecord::Migration[4.2]
  def change
    add_index :payment_methods, [:id, :type]
    add_index :calculators, [:id, :type]
    add_index :calculators, [:calculable_id, :calculable_type]
    add_index :payments, :payment_method_id
    add_index :promotion_actions, [:id, :type]
    add_index :promotion_actions, :promotion_id
    add_index :promotions, [:id, :type]
    add_index :option_values, :option_type_id
    add_index :shipments, :stock_location_id
  end
end
