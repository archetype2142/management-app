class AddBackorderableDefaultToSpreeStockLocation < ActiveRecord::Migration[4.2]
  def change
    add_column :stock_locations, :backorderable_default, :boolean, default: true
  end
end
