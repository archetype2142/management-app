class UpdateProductSlugIndex < ActiveRecord::Migration[4.2]
  def change
    remove_index :products, :slug if index_exists?(:products, :slug)
    add_index :products, :slug, unique: true
  end
end
