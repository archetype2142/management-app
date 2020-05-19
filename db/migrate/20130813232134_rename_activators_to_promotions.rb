class RenameActivatorsToPromotions < ActiveRecord::Migration[4.2]
  def change
    rename_table :activators, :promotions
  end
end
