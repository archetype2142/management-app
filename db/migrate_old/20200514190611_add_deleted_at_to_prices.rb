class AddDeletedAtToPrices < ActiveRecord::Migration[6.0]
  def change
    add_column :prices, :deleted_at, :datetime
  end
end
