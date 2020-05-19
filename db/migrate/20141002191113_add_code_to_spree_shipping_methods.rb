class AddCodeToSpreeShippingMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :shipping_methods, :code, :string
  end
end
