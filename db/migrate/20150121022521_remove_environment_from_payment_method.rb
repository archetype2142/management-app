class RemoveEnvironmentFromPaymentMethod < ActiveRecord::Migration[4.2]
  def up
    PaymentMethod.where('environment != ?', Rails.env).update_all(active: false)
    remove_column :payment_methods, :environment
  end
end
