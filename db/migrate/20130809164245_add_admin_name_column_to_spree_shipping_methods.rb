class AddAdminNameColumnToSpreeShippingMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :shipping_methods, :admin_name, :string
  end
end
