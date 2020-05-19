class AddPositionToProductProperties < ActiveRecord::Migration[4.2]
  def change
    add_column :product_properties, :position, :integer, default: 0
  end
end

