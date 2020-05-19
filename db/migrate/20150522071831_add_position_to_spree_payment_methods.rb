class AddPositionToSpreePaymentMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :payment_methods, :position, :integer, default: 0
  end
end
