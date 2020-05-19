class AddUniqueIndexOnSpreePromotionsCode < ActiveRecord::Migration[5.1]
  def change
    remove_index :promotions, :code
    add_index :promotions, :code, unique: true
  end
end
