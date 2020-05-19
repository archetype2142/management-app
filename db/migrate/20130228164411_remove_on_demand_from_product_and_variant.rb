class RemoveOnDemandFromProductAndVariant < ActiveRecord::Migration[4.2]
  def change
    remove_column :products, :on_demand
    remove_column :variants, :on_demand
  end
end
