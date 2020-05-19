class AddStoreIdToPaymentMethods < ActiveRecord::Migration[5.2]
  def change
    unless column_exists?(:payment_methods, :store_id)
      add_reference :payment_methods, :store, references: :stores, index: true
    end
  end
end
