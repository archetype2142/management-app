class AddDeletedAtToSpreePromotionActions < ActiveRecord::Migration[4.2]
  def change
    add_column :promotion_actions, :deleted_at, :datetime
    add_index :promotion_actions, :deleted_at
  end
end
