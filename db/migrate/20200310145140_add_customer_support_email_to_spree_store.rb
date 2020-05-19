class AddCustomerSupportEmailToSpreeStore < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:stores, :customer_support_email)
      add_column :stores, :customer_support_email, :string
    end
  end
end
