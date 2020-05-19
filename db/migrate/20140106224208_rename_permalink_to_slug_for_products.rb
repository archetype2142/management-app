class RenamePermalinkToSlugForProducts < ActiveRecord::Migration[4.2]
  def change
    rename_column :products, :permalink, :slug
  end
end
