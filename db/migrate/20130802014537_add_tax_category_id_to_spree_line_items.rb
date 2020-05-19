class AddTaxCategoryIdToSpreeLineItems < ActiveRecord::Migration[4.2]
  def change
    add_column :line_items, :tax_category_id, :integer
  end
end
