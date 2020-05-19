class RemoveNotNullConstraintFromProductsOnHand < ActiveRecord::Migration[4.2]
  def up
    change_column :products, :count_on_hand, :integer, null: true
    change_column :variants, :count_on_hand, :integer, null: true
  end

  def down
    change_column :products, :count_on_hand, :integer, null: false
    change_column :variants, :count_on_hand, :integer, null: false
  end
end
