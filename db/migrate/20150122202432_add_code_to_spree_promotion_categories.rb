class AddCodeToSpreePromotionCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :promotion_categories, :code, :string
  end
end
