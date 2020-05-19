class CreateSpreeStoreCreditCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :store_credit_categories do |t|
      t.string :name
      t.timestamps null: false, precision: 6
    end
  end
end
