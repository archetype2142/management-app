class AddPrimaryToSpreeProductsTaxons < ActiveRecord::Migration[4.2]
  def change
    add_column :products_taxons, :id, :primary_key
  end
end
