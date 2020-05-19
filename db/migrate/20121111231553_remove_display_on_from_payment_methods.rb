class RemoveDisplayOnFromPaymentMethods < ActiveRecord::Migration[4.2]
  def up
    remove_column :payment_methods, :display_on
  end
end
