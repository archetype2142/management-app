class AddPositionToClassifications < ActiveRecord::Migration[4.2]
  def change
    add_column :products_taxons, :position, :integer
  end
end
