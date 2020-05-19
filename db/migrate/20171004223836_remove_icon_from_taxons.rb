class RemoveIconFromTaxons < ActiveRecord::Migration[5.1]
  def change
    remove_column :taxons, :icon_file_name if column_exists? :taxons, :icon_file_name
    remove_column :taxons, :icon_content_type if column_exists? :taxons, :icon_content_type
    remove_column :taxons, :icon_file_size if column_exists? :taxons, :icon_file_size
    remove_column :taxons, :icon_updated_at if column_exists? :taxons, :icon_updated_at
  end
end
