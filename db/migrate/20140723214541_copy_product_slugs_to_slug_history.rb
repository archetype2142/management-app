class CopyProductSlugsToSlugHistory < ActiveRecord::Migration[4.2]
  def change

	# do what sql does best: copy all slugs into history table in a single query
	# rather than load potentially millions of products into memory
	Product.connection.execute <<-SQL
INSERT INTO #{FriendlyId::Slug.table_name} (slug, sluggable_id, sluggable_type, created_at)
  SELECT slug, id, '#{Product.to_s}', #{ApplicationRecord.send(:sanitize_sql_array, ['?', Time.current])} 
  FROM #{Product.table_name}
  WHERE slug IS NOT NULL
  ORDER BY id
SQL

  end
end
