class AddTrackingUrlToSpreeShippingMethods < ActiveRecord::Migration[4.2]
  def change
    add_column :shipping_methods, :tracking_url, :string
  end
end
