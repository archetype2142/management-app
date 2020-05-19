class AddUserIdCreatedByIdIndexToOrder < ActiveRecord::Migration[4.2]
  def change
    add_index :orders, [:user_id, :created_by_id]
  end
end
