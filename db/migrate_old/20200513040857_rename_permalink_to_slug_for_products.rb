class RenamePermalinkToSlugForProducts < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :permalink, :slug
  end
end
