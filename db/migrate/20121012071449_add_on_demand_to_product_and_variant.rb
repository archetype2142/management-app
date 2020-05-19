class AddOnDemandToProductAndVariant < ActiveRecord::Migration[4.2]
  def change
  	add_column :products, :on_demand, :boolean, default: false
  	add_column :variants, :on_demand, :boolean, default: false
  end
end
