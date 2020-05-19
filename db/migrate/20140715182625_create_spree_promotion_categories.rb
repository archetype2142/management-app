class CreateSpreePromotionCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :promotion_categories do |t|
      t.string :name
      t.timestamps null: false, precision: 6
    end

    add_column :promotions, :promotion_category_id, :integer
    add_index :promotions, :promotion_category_id
  end
end
