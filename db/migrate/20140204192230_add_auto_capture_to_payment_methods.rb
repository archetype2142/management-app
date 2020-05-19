class AddAutoCaptureToPaymentMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :payment_methods, :auto_capture, :boolean
  end
end
