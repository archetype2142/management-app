class AddTaxCategoryToVariants < ActiveRecord::Migration[4.2]
  def change
    add_column :variants, :tax_category_id, :integer
    add_index  :variants, :tax_category_id
  end
end
