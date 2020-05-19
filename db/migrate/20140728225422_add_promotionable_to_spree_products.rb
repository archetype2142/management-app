class AddPromotionableToSpreeProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :promotionable, :boolean, default: true
  end
end
